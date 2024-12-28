import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:create_spurte/src/exceptions.dart';
import 'package:create_spurte/src/fs/files.dart';
import 'package:io/ansi.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as p;

void scaffoldProject(
    String name, String dir, VFileSystemEntity Function(String path) templ,
    {required Logger logger, bool override = false}) {
  var _override = override;

  final directory = Directory(p.join(dir, name));
  if (directory.existsSync() && !override) {
    final dialog = CLI_Dialog(messages: [
      ['The directory at $dir exists.', 'msg']
    ], booleanQuestions: [
      ['Do you want to force create it?', 'force']
    ]);
    _override = dialog.ask()['force'];

    if (!_override) {
      logger.stderr(
          'Cannot write to directory: ${styleBold.wrap('Already exists')}');
    }
  }

  var progress = logger.progress('Scaffolding project');

  templ(name).create(dir);

  progress.finish(
      message: '\nProject scaffolded at ${p.join(dir, name)}!',
      showTiming: logger is VerboseLogger);
}

void getDependencies(String dir, {required Logger logger}) async {
  bool verbose = logger is VerboseLogger;
  final dialog = CLI_Dialog(booleanQuestions: [
    ['Should I run "pub get" for you?', 'get']
  ]);
  final get = dialog.ask()['get'];

  if (get) {
    var progress = logger.progress('Running "pub get"');

    final manager = ProcessManager();

    logger.trace('** Running "dart pub get" **');
    final process = await manager.spawnDetached('dart', ['pub', 'get'],
        workingDirectory: dir);

    process.stdout
        .transform(utf8.decoder)
        .listen((e) => logger.trace(styleItalic.wrap(e) ?? ''));

    if (await process.exitCode != 0) {
      final ext = await process.exitCode;
      process.stderr
          .transform(utf8.decoder)
          .listen((e) => logger.trace(red.wrap(e) ?? ''));
      throw SpurteException('Process exited with code $ext', exitCode: ext);
    }

    progress.finish(message: '\nGotten dependencies', showTiming: verbose);
  }
}
