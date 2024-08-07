import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dyte/src/bundler/dart2js.dart';
import 'package:frontend_server_client/frontend_server_client.dart';
import 'package:io/ansi.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:shelf_packages_handler/shelf_packages_handler.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'options/server_options.dart';
import 'bundler/dartdevc.dart';
import 'bundler/common.dart';

class DyteServerResult {
  final HttpServer _server;
  final Function close;

  const DyteServerResult._({required this.close, required HttpServer server}): _server = server;

  HttpServer get server => _server;
}

class DyteServer {
  final Future<DyteServerResult> Function(int port, {void Function()? onListen, void Function()? onEnd}) listen;

  final DartDevcFrontendServerClient? _devClient;
  final bool dev;
  final String entrypoint;

  const DyteServer._({
    required this.listen,
    DartDevcFrontendServerClient? devClient,
    this.dev = true,
    required this.entrypoint
  }): _devClient = devClient;

  void repl(HttpServer server) async {
    final stdinQueue = StreamQueue(
      stdin.transform(utf8.decoder).transform(const LineSplitter())
    );
    while (await stdinQueue.hasNext) {
      final newMessage = await stdinQueue.next;
      switch (newMessage) {
        case "h":
          print(blue.wrap("Options: \n    ${helpOptions.entries.map((kv) => "${styleBold.wrap(kv.key)}: ${kv.value}").join("\n    ")}"));
          break;
        case "R":
          print(red.wrap("Resetting..."));
          _devClient?.reset();
          print("Project reset");
        case "r":
          print("Performing reload...");
          if (_devClient != null) {
            await recompile(_devClient, entrypoint);
          }
        case 'q':
          print("Exiting program");
          await server.close();
          if (_devClient != null) terminateClient(_devClient, error: false);
          await stdinQueue.cancel();
        default:
      }
    }
  }
}

Map<String, String> get helpOptions => {
  'h': 'Prints out help information',
  'r': 'Produces a hot reload of the server',
  'R': 'Restarts the server back to its previous state',
  'q': 'Ends the server program',
  'Q': 'Forcefully ends the program',
};

Handler _clientHandler(DartDevcFrontendServerClient client, {String entrypoint = "web/main.dart"}) {
  return (Request request) {
    var path = request.url.path;
    final packagesIndex = path.indexOf('/packages/');
    if (packagesIndex > 0) {
      path = request.url.path.substring(packagesIndex);
    } else {
      path = request.url.path;
    }
    if (!path.startsWith('/')) path = '/$path';
    if (path.endsWith('.dart.js') && path != '/$entrypoint.js') {
      path = path.replaceFirst('.dart.js', '.dart.lib.js', path.length - 8);
    }
    final assetBytes = client.assetBytes(path);
    if (assetBytes == null) return Response.notFound('path not found');
    return Response.ok(assetBytes,
        headers: {HttpHeaders.contentTypeHeader: 'application/javascript'});
  };
}

Future<DyteServer> serve(ServerOptions options) async {
  DartClientResult client;
  String relativeEntry = p.isRelative(options.entry) ? options.entry : p.relative(options.entry, from: options.cwd);
  if (options.prodServer) {
    client = await dart2JsServer(relativeEntry, Directory(options.cwd));
  } else {
    client = await dartDevCServer(relativeEntry, Directory(options.cwd));
  }

  // TODO: use pipeline
  Cascade cascade = await buildServer(client, relativeEntry, options);
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(cascade.handler);

  // https
  final chain = options.cert == null ? null : Platform.script.resolve(options.cert ?? "").toFilePath();
  final key = options.key == null ? null : Platform.script.resolve(options.key ?? "").toFilePath();

  final context = SecurityContext.defaultContext;
  if (chain != null) context.useCertificateChain(chain);
  if (key != null) context.usePrivateKey(key);

  // return server
  return DyteServer._(
    entrypoint: options.entry,
    listen: (int port, {void Function()? onListen, void Function()? onEnd}) async {
      final server = await io.serve(
        handler,
        options.host, 
        port, 
        securityContext: (chain != null && key != null) ? context : null,
        poweredByHeader: "Dyte - Powerful frontend tooling"
      );

      (onListen ?? (){})();
      // autocompression?
      //
      return DyteServerResult._(close: (bool force, {void Function()? onClose}) {
        server.close(force: force);
        (onClose ?? (){})();
      }, server: server);
    },
    dev: !options.prodServer,
    devClient: client is DartDevClientResult ? client.client : null
  );
}

Future<Cascade> buildServer(DartClientResult devClient, String relativeEntry, ServerOptions options) async {
  bool dev = devClient is DartDevClientResult;
  var cascade = Cascade();
  if (dev) {
    cascade = cascade.add(_clientHandler(devClient.client, entrypoint: relativeEntry));
  }
  // serve public dir
  cascade = cascade.add((request) {
    var path = request.url.path;
    if (!path.startsWith('/')) path = "/$path";
  
    final actualPath = p.join(options.publicDir, path.replaceFirst('/${options.publicDir}', '').replaceFirst('/', ''));
  
    if (
      path.startsWith(options.publicRoot) && 
      File(p.join(options.cwd, actualPath)).existsSync()
    ) {
      return createStaticHandler(actualPath)(request);
    } else {
      return Response.notFound('The path $path could not be found.');
    }
  })
  // serve file if requested
  .add(createStaticHandler(options.cwd, defaultDocument: "index.html"));
  
  if (dev) {
    cascade = cascade.add(createFileHandler(devClient.dartSdk, url: p.join(p.dirname(relativeEntry), 'dart_sdk.js')))
    .add(createFileHandler("${devClient.dartSdk}.map", url: p.join(p.dirname(relativeEntry), 'dart_sdk.js.map')))
    .add(createFileHandler(
            p.join(sdkDir, 'lib', 'dev_compiler', 'web',
                'dart_stack_trace_mapper.js'),
            url: 'dart_stack_trace_mapper.js'))
    .add(createFileHandler(
            p.join(sdkDir, 'lib', 'dev_compiler', 'amd', 'require.js'),
            url: 'require.js'))  
    .add(packagesDirHandler(packageMap: await getPackageMap(options.cwd)))      
    ;
  }
  return cascade;
}

Future<Map<String, Uri>> getPackageMap(String cwd) async {
  final packageConfig = await findPackageConfig(Directory(cwd));
  final packages = packageConfig?.packages ?? [];
  return { for (final pkg in packages) pkg.name : pkg.packageUriRoot };
}