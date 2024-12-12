import 'dart:async';
import 'dart:io';

import 'package:browser_launcher/browser_launcher.dart';
import 'package:io/ansi.dart';

import '../cli/shared.dart';
import '../config_file.dart';
import '../options/options.dart';
import '../plugin.dart';
import '../serve.dart';
import 'base/command.dart';

class RunCommand extends SpurteCommand {
  @override
  final String name = "run";

  @override
  final String description = "Start a development server for your app";

  RunCommand() {
    argParser..addFlag(
      'launch',
      abbr: 'l',
      negatable: false,
      defaultsTo: false,
      help: 'Launch app in browser once loaded (Chrome only supported)'
    )..addFlag(
      'repl',
      help: 'Whether to include a REPL for controlling the app from the command line',
      negatable: true,
      defaultsTo: true,
    )..addFlag(
      'log-requests',
      negatable: false,
      defaultsTo: false,
      help: "Log requests (verbose) to the standard output"
    )
    ;
  }

  @override
  FutureOr? run() async {
    final result = await preCommand(argResults?.rest ?? [], logger, spurteRunner);

    final config = result.config;
    final projectDir = result.cwd;

    // run plugins
    try {
      await runPlugins(config.plugins?.toList() ?? [], projectDir, config: getConfigFile(projectDir, "spurte"), dev: true);
    } catch (e) {
      logger.error(e.toString(), error: true);
      exit(1);
    }

    // create server options from configuration
    final serverOptions = createServerOptions(config, projectDir.path);

    // build web server and run
    final server = await serve(serverOptions, log: argResults?['log-requests']);

    final serverDest = "http${config.server?.https == null ? "" : "s"}://${config.server?.host ?? "localhost"}:${config.server?.port ?? 8000}";

    final webServer = await server.listen(
      serverOptions.port, 
      onListen: () => print(blue.wrap("""${styleBold.wrap("SPURTE")}

Web Server Started!
- Local: ${yellow.wrap(serverDest)}
"""
))
    );

    if (argResults?['launch']) {
      // launch website
      if (!(await launchBrowser(serverDest))) {
        print("Could not launch site.");
      }
    }

    if (argResults?['repl']) server.repl(webServer.server);
  }
}

Future<bool> launchBrowser(String url) async {
  // check if user has chrome
  final chrome = await Chrome.start([url]);
  if (await chrome.exitCode == 0) {
    // chrome started!
    return true;
  }

  // if not then try others
  // check for safari
  if (Platform.isMacOS) {
    final safari = await Process.start('open', ['-a', 'Safari', url], mode: ProcessStartMode.detached);

    if (await safari.exitCode == 0) {
      return true;
    }
  }

  // check for firefox
  final firefox = await Process.start('firefox', [url], mode: ProcessStartMode.detached);

  if (await firefox.exitCode == 0) {
    return true;
  }

  // can't
  return false;
}