library spurte.cli;

import 'commands/base/runner.dart';

import 'commands/run.dart';

void run(List<String> args) {
  SpurteCommandRunner("spurte", "Powerful frontend tooling at your fingertips",
      version: "0.0.1")
    ..addCommand(RunCommand())
    ..run(args);
}
