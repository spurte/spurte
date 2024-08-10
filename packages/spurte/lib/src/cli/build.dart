import 'dart:async';
import 'dart:io';
import 'package:spurte/src/build.dart';
import 'package:spurte/src/config_file.dart';
import 'package:spurte/src/options/options.dart';
import 'package:spurte/src/plugin.dart';
import 'package:spurte/src/schema/config.dart';
import 'package:spurte/src/utils/logger.dart';

Future<void> buildProject(SpurteConfig config, Directory projectDir, {required SpurteLogger logger}) async {
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