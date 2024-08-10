library spurte.cli;

import 'commands/base/runner.dart';

import 'commands/prod.dart';
import 'commands/build.dart';
import 'commands/run.dart';

void run(List<String> args) {
  SpurteCommandRunner("spurte", "Powerful frontend tooling at your fingertips",
      version: "0.0.1")
    ..addCommand(RunCommand())
    ..addCommand(BuildCommand())
    ..addCommand(ProdCommand())
    ..run(args);
}
