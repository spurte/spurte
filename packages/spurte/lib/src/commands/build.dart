import 'dart:async';
import 'dart:io';

import '../cli/shared.dart';
import '../build.dart';
import '../options/options.dart';
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

    // get build options
    final options = createBuildOptions(config, projectDir.path);

    logger.info("Building for production...");
    await build(options);

    logger.fine("Done Building!");
  }
}
