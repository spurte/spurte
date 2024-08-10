import 'dart:async';

import 'package:spurte/src/cli/build.dart';

import '../cli/shared.dart';
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
    await buildProject(config, projectDir, logger: logger);
  }
}