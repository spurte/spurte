import 'dart:async';
import 'dart:io';

import 'package:io/ansi.dart';
import 'package:path/path.dart' as p;

import '../file_serve.dart';
import '../cli/build.dart';

import '../cli/shared.dart';
import 'base/command.dart';

class ProdCommand extends SpurteCommand {
  @override
  String get description => "Serve the build of your Spurte Application";

  @override
  String get name => "prod";

  @override
  FutureOr? run() async {
    final result = await preCommand(argResults?.rest ?? [], logger, spurteRunner);

    final config = result.config;
    final projectDir = result.cwd;

    final distDir = Directory(p.join(projectDir.path, config.build?.outdir ?? "dist"));

    if (!(distDir.existsSync() && distDir.listSync().isNotEmpty)) {
      logger.warn("Build not available, building project...");

      await buildProject(config, projectDir, logger: logger);

      print("\n");
    }

    final serverDest = "http${config.prod?.https == null ? "" : "s"}://${config.prod?.host ?? "localhost"}:${config.prod?.port ?? 3000}";

    // run file server
    await runFileServer(distDir, config, onListen: () => print(blue.wrap("""${styleBold.wrap("SPURTE")}

Prod File Server Started!
- Local: ${yellow.wrap(serverDest)}
"""
)));
  }
  
}
