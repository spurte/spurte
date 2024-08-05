import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:shelf_static/shelf_static.dart';

import 'options/server_options.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class DyteServer {
  Future<DyteServerResult> Function(int port, {void Function()? onListen, void Function()? onEnd}) listen;

  DyteServer({required this.listen});
}

DyteServer serve(ServerOptions options) {
  // TODO: use pipeline
  var cascade = Cascade()
  .add(createFileHandler(options.index, url: '/'))
  .add((request) {
    var path = request.url.path;
    if (!path.startsWith('/')) path = "/$path";

    if (path.startsWith(options.publicRoot)) {
      return createStaticHandler(p.join(options.publicDir, path.replaceFirst('/${options.publicDir}', '').replaceFirst('/', '')))(request);
    } else {
      return Response.notFound('The path $path could not be found.');
    }
  });

  // https
  final chain = options.cert == null ? null : Platform.script.resolve(options.cert ?? "").toFilePath();
  final key = options.key == null ? null : Platform.script.resolve(options.key ?? "").toFilePath();

  final context = SecurityContext.defaultContext;
  if (chain != null) context.useCertificateChain(chain);
  if (key != null) context.usePrivateKey(key);

  // return server
  return DyteServer(
    listen: (int port, {void Function()? onListen, void Function()? onEnd}) async {
      final server = await io.serve(
        cascade.handler, 
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
    }
  );
}

class DyteServerResult {
  final HttpServer _server;
  final Function close;

  const DyteServerResult._({required this.close, required HttpServer server}): _server = server;

  HttpServer get server => _server;
}