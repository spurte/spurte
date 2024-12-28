import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

import 'package:spurte/src/schema/config.dart';

Future<HttpServer> runFileServer(Directory distDir, SpurteConfig config,
    {void Function()? onListen, bool log = false}) async {
  // set up the file server
  var distDirPath = distDir.absolute.path;
  var staticHandler =
      createStaticHandler(distDirPath, defaultDocument: 'index.html');
  var handler = log
      ? Pipeline().addMiddleware(logRequests()).addHandler(staticHandler)
      : staticHandler;

  // https
  final chain = config.prod?.https?.cert == null
      ? null
      : Platform.script.resolve(config.prod?.https?.cert ?? "").toFilePath();
  final key = config.prod?.https?.key == null
      ? null
      : Platform.script.resolve(config.prod?.https?.key ?? "").toFilePath();

  final context = SecurityContext.defaultContext;
  if (chain != null) context.useCertificateChain(chain);
  if (key != null) context.usePrivateKey(key);

  final server = await io.serve(
      handler, config.prod?.host ?? 'localhost', config.prod?.port ?? 3000,
      securityContext: (chain != null && key != null) ? context : null,
      poweredByHeader: "Spurte - Powerful frontend tooling");

  (onListen ?? () {})();

  return server;
}
