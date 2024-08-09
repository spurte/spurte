import 'dart:convert';

import 'package:io/ansi.dart';
import 'package:io/io.dart';

import 'logger.dart';

class SpurteRunner {
  final SpurteLogger _logger;
  final ProcessManager _manager;

  SpurteRunner({SpurteLogger? logger})
      : _logger = logger ?? SpurteLogger(),
        _manager = ProcessManager();

  Future<int> run(String cmd,
      {List<String> args = const [], String? cwd}) async {
    var spawn = await _manager.spawn(cmd, args, workingDirectory: cwd);
    spawn.stdout.transform(utf8.decoder).listen(_logger.cmd);
    spawn.stderr
        .transform(utf8.decoder)
        .listen((event) => _logger.verbose(red.wrap(event) ?? event));

    var code = await spawn.exitCode;
    if (code != 0) {
      _logger.error("Error running command ${[
        cmd,
        ...args
      ].join(" ")}: Process exited with exit code $code");
    }

    return code;
  }
}
