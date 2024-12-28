import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:create_spurte/src/cli.dart';
import 'package:io/ansi.dart';

void main(List<String> arguments) {
  try {
    run(arguments);
  } on UsageException catch (e) {
    print(red.wrap(e.message));
    print('');
    print(e.usage);
  }
}
