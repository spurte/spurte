import 'dart:async';
import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;

import '../config/config.dart';
import '../config/internal/default_config.dart';
import '../config_file.dart';
import '../utils/logger.dart';
import '../utils/runner.dart';

Future<SpurteCommandResult> preCommand(
    List<String> args, SpurteLogger logger, SpurteRunner runner) async {
  // get directory
  final cwd = Directory.current;

  final dir = args.isEmpty ? "." : args[0];
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
    var success = (await runner.run("dart",
            args: ["pub", "get"], cwd: projectDir.path)) ==
        0;

    if (!success) {
      logger.error("Cannot resolve package. Run --verbose to see logging",
          error: true);
      exit(1);
    }
  }

  // get configuration
  final config = mergeConfig(getConfiguration(projectDir, name: "spurte"),
      defaultConfig(SpurteMode.DEVELOPMENT, projectDir.path));

  return SpurteCommandResult(
      config: config, cwd: projectDir, configName: 'spurte');
}

class SpurteCommandResult {
  SpurteConfig config;

  Directory cwd;

  String configName;

  SpurteCommandResult(
      {required this.config, required this.cwd, this.configName = 'dart'});
}
