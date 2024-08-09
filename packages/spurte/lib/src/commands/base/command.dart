import 'package:args/command_runner.dart';
import 'package:spurte/src/utils/runner.dart';
import 'runner.dart';
import '../../utils/logger.dart';

abstract class SpurteCommand<T> extends Command<T> {
  SpurteLogger? _logger;
  SpurteLogger get logger {
    if (runner is SpurteCommandRunner) {
      _logger ??= SpurteLogger(verbose: (runner as SpurteCommandRunner).verbose);
      return _logger ??
          SpurteLogger(verbose: (runner as SpurteCommandRunner).verbose);
    } else {
      throw Exception(
          "Logger cannot be used here: the runner is not of instance SpurteCommandRunner");
    }
  }

  SpurteRunner? _spurteRunner;
  SpurteRunner get spurteRunner {
    _spurteRunner ??= SpurteRunner(logger: _logger);
    return _spurteRunner ?? SpurteRunner(logger: _logger);
  }
}
