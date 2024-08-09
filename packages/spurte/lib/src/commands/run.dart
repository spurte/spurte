import 'dart:async';
import 'dart:io';

import '../cli/shared.dart';
import '../config_file.dart';
import '../options/options.dart';
import '../plugin.dart';
import '../serve.dart';
import 'base/command.dart';

class RunCommand extends SpurteCommand {
  @override
  final String name = "run";

  @override
  final String description = "Start a development server for your app";

  @override
  FutureOr? run() async {
    final result = await preCommand(argResults?.rest ?? [], logger, spurteRunner);

    final config = result.config;
    final projectDir = result.cwd;

    // run plugins
    try {
      await runPlugins(config.plugins?.toList() ?? [], projectDir, config: getConfigFile(projectDir, "spurte"));
    } catch (e) {
      logger.error(e.toString(), error: true);
      exit(1);
    }

    // create server options from configuration
    final serverOptions = createServerOptions(config, projectDir.path);

    // build web server and run
    final server = await serve(serverOptions);

    final webServer = await server.listen(
      serverOptions.port, 
      onListen: () => print("Server started on http${config.server?.https == null ? "" : "s"}://${config.server?.host ?? "localhost"}:${config.server?.port ?? 8000}")
    );

    server.repl(webServer.server);
  }
}
