import 'dart:async';
import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;

import '../config/config.dart';
import '../config/internal/server_config.dart';
import '../config_file.dart';
import '../options/options.dart';
import '../plugin.dart';
import '../serve.dart';
import 'base/command.dart';

class RunCommand extends DyteCommand {
  @override
  final String name = "run";

  @override
  final String description = "Start a development server for your app";

  @override
  FutureOr? run() async {
    // get directory
    final cwd = Directory.current;

    final dir = (argResults?.rest ?? []).isEmpty ? "." : argResults!.rest[0];
    final projectDir = Directory(p.join(cwd.absolute.path, dir));
    if (!(await projectDir.exists())) {
      logger.error("The directory at ${projectDir.path} does not exist",
          error: true);
      exit(1);
    }

    // ensure package has been built and all dependencies installed
    final packageConfigPath =
        File(p.join(projectDir.path, ".dart_tool", "package_config.json"));
    final packageConfig = await findPackageConfig(projectDir);

    if (!(await packageConfigPath.exists()) || packageConfig == null) {
      logger.warn("Package config cannot be found");
      logger.info("Running 'dart pub get'");
      var success = (await dyteRunner.run("dart",
              args: ["pub", "get"], cwd: projectDir.path)) ==
          0;

      if (!success) {
        logger.error("Cannot resolve package. Run --verbose to see logging",
            error: true);
        exit(1);
      }
    }

    // get configuration
    final config = mergeConfig(getConfiguration(projectDir, name: "dyte"), defaultConfig(DyteMode.development, projectDir.path));

    // run plugins
    try {
      await runPlugins(config.plugins?.toList() ?? [], projectDir, config: getConfigFile(projectDir, "dyte"));
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
