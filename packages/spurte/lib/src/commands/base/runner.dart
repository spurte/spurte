import 'package:args/command_runner.dart';

class SpurteCommandRunner extends CommandRunner {
  final String version;

  bool get verbose => _verbose ?? false;
  bool? _verbose;

  SpurteCommandRunner(super.executableName, super.description,
      {this.version = "0.1.0"})
      : super() {
    argParser
      ..addFlag('version',
          abbr: 'v',
          negatable: false,
          help: "Print out the current pheasant version")
      ..addFlag('verbose',
          abbr: 'V', negatable: false, help: "Output Verbose Logging")
      ..addFlag('define',
          abbr: 'D', help: 'Define overrides to given config options');
  }

  @override
  Future run(Iterable<String> args) {
    if (args.contains('--version') || args.contains('-v')) {
      return Future.sync(() => print('$executableName version: $version'));
    }
    if (args.contains('--verbose') || args.contains('-V')) {
      _verbose = true;
    }
    return super.run(args);
  }
}
