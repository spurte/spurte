import 'package:args/command_runner.dart';
import 'package:dyte/src/utils/runner.dart';
import 'runner.dart';
import '../../utils/logger.dart';

abstract class DyteCommand<T> extends Command<T> {
  DyteLogger? _logger;
  DyteLogger get logger {
    if (runner is DyteCommandRunner) {
      _logger ??= DyteLogger(verbose: (runner as DyteCommandRunner).verbose);
      return _logger ?? DyteLogger(verbose: (runner as DyteCommandRunner).verbose);
    } else {
      throw Exception("Logger cannot be used here: the runner is not of instance DyteCommandRunner");
    }
  }

  DyteRunner? _dyteRunner;
  DyteRunner get dyteRunner {
    _dyteRunner ??= DyteRunner(logger: _logger);
    return _dyteRunner ?? DyteRunner(logger: _logger);
  }
}
