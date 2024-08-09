import 'dart:async';
import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;

import '../build.dart';
import '../options/options.dart';
import '../config/config.dart';
import '../config/internal/server_config.dart';
import '../config_file.dart';
import '../plugin.dart';
import 'base/command.dart';

class BuildCommand extends SpurteCommand {
  @override
  final String name = "build";

  @override
  final String description = "Build your spurte application";

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
      var success = (await spurteRunner.run("dart",
              args: ["pub", "get"], cwd: projectDir.path)) ==
          0;

      if (!success) {
        logger.error("Cannot resolve package. Run --verbose to see logging",
            error: true);
        exit(1);
      }
    }

    // get configuration
    final config = mergeConfig(getConfiguration(projectDir, name: "spurte"), defaultConfig(SpurteMode.development, projectDir.path));

    // run plugins
    try {
      await runPlugins(config.plugins?.toList() ?? [], projectDir, config: getConfigFile(projectDir, "spurte"));
    } catch (e) {
      logger.error(e.toString(), error: true);
      exit(1);
    }

    // get build options
    final options = createBuildOptions(config, projectDir.path);

    logger.info("Building for production...");
    await build(options);

    logger.fine("Done Building!");
  }
}
