import 'package:cli_util/cli_logging.dart' as cli;
import 'package:io/ansi.dart';

enum LogMode { info, warn, error, fine, cmd, none }

/// A wrapper around a dart [cli.Logger] for internal use and convenience when logging or printing messages
///
/// Allows for easy logging for dyte functionality
class DyteLogger {
  final cli.Logger _logger;
  final bool _verbose;

  DyteLogger({bool verbose = false})
      : _verbose = verbose,
        _logger = verbose ? cli.Logger.verbose() : cli.Logger.standard();

  print(String msg, LogMode mode) {
    switch (mode) {
      case LogMode.info:
        info(msg);
        break;
      case LogMode.warn:
        warn(msg);
        break;
      case LogMode.error:
        error(msg);
        break;
      case LogMode.fine:
        fine(msg);
        break;
      case LogMode.cmd:
        cmd(msg);
        break;
      case LogMode.none:
        stdout(msg);
        break;
    }
  }

  void stdout(String msg) => _logger.stdout(msg);
  void stderr(String msg) => _logger.stderr(msg);
  void info(String msg) {
    if (_verbose) {
      _logger.stdout("${blue.wrap("[INFO]")} $msg");
    } else {
      _logger.stdout(blue.wrap(msg)!);
    }
  }

  void warn(String msg) {
    if (_verbose) {
      _logger.stdout("${yellow.wrap("[WARN]")} $msg");
    } else {
      _logger.stdout(yellow.wrap(msg)!);
    }
  }

  void error(String msg, {bool error = false}) {
    if (_verbose) {
      (error ? _logger.stderr : _logger.stdout)("${red.wrap("[SEVERE]")} $msg");
    } else {
      (error ? _logger.stderr : _logger.stdout)(red.wrap(msg)!);
    }
  }

  void fine(String msg) {
    if (_verbose) {
      _logger.stdout("${green.wrap("[FINE]")} $msg");
    } else {
      _logger.stdout(green.wrap(msg)!);
    }
  }

  void cmd(String msg, {bool error = false}) {
    if (_verbose) {
      (error
          ? _logger.stderr
          : _logger.stdout)("${magenta.wrap("[CMD]")} $msg");
    } else {
      (error ? _logger.stderr : _logger.stdout)(magenta.wrap(msg)!);
    }
  }

  void verbose(String msg) {
    if (_verbose) _logger.trace("[VERBOSE] $msg");
  }
}
