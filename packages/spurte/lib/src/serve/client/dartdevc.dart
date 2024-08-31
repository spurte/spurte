import 'dart:async';
import 'dart:io';

import 'package:spurte/src/config_file.dart';
import 'package:frontend_server_client/frontend_server_client.dart';
import 'package:path/path.dart' as p;
import 'package:watcher/watcher.dart';

import 'common.dart';

final sdkDdcKernelPath = p.join(sdkDir, 'lib', '_internal', 'ddc_platform.dill');

String dartSdk(String dir) => p.join(dir, '.dart_tool', 'out', 'dart_sdk.js');
String outputDill(String dir, [String name = 'app']) => p.join(dir, '.dart_tool', 'out', '$name.dill');

Future<void> compileDartSdk(Directory dir) async {
  // TODO: Experiment with options
  final sdkCompileResult = await Process.run(Platform.resolvedExecutable, [
    p.join(sdkDir, 'bin', 'snapshots', 'dartdevc.dart.snapshot'),
    '--multi-root-scheme=org-dartlang-sdk',
    '--modules=amd',
    '--module-name=dart_sdk',
    '--sound-null-safety',
    '-o', dartSdk(dir.path),
    p.url.join(sdkDir, sdkDdcKernelPath)
  ]);

  if (sdkCompileResult.exitCode != 0) {
    print("Failed to compile the dart sdk: \n${sdkCompileResult.stdout}\n${sdkCompileResult.stderr}");
    exit(sdkCompileResult.exitCode);
  }
}

Future<DartDevcFrontendServerClient> startDevServer(String entrypoint, Directory dir, [bool verbose = false]) async {
  final name = p.basenameWithoutExtension(entrypoint);
  final client = await DartDevcFrontendServerClient.start(
    'org-dartlang-root:///${p.isAbsolute(entrypoint) ? p.relative(entrypoint, from: dir.path) : entrypoint}', outputDill(dir.path, name),
    fileSystemRoots: [dir.path],
    fileSystemScheme: 'org-dartlang-root',
    platformKernel: p.toUri(sdkDdcKernelPath).toString(),
    verbose: verbose,
    packagesJson: p.join(dir.path, '.dart_tool', 'package_config.json')
  );

  return client;
}

compileDevServer(DartDevcFrontendServerClient client) async {
  await client.compile([]);
  client.accept();
}

Future<DartDevClientResult> dartDevCServer(String entrypoint, Directory dir, {List<String> ignore = const [], List<String> important = const [], List<String> recompileOnChange = const []}) async {
  // compile dart sdk
  await compileDartSdk(dir);

  // get client running
  final client = await startDevServer(entrypoint, dir);
  await client.compile([]);
  client.accept();

  var watcher = DirectoryWatcher(dir.path);

  final ignorePaths = (ignore + [".dart_tool"]).map((e) => p.join(dir.path, e));
  final importantPaths = (important + [getConfigFile(dir, 'spurte'), 'pubspec.yaml']).map((e) => p.join(dir.path, e));

  var clientActive = false;

  watcher.events.listen((event) async {
    if (ignorePaths.where((element) => (p.isAbsolute(event.path) ? event.path : p.join(dir.path, event.path)) == element).isNotEmpty) {
      // ignore change
    } else {
      if (clientActive) {
        return;
      }
      clientActive = true;
      // address change
      try {
        switch (event.type.toString()) {
          case "remove":
            if (importantPaths.where((element) => (p.isAbsolute(event.path) ? event.path : p.join(dir.path, event.path)) == element).isNotEmpty) {
              // removed important file
              print("File ${event.path} removed");
              // terminate
              print("Terminating program until file is recovered");
              terminateClient(client, error: false);
            } else {
              print("File ${event.path} removed. Recompiling...");
              await recompile(client, entrypoint); 
            }
            break;
          case "add":
            // added new file
            if (p.extension(event.path) == ".dart" || recompileOnChange.contains(p.isRelative(event.path) ? event.path : p.relative(event.path, from: dir.path))) {
              print("File ${event.path} added. Recompiling...");
              await recompile(client, entrypoint); 
            }  

          case "modify":
            // modified file
            if (p.extension(event.path) == ".dart" || recompileOnChange.contains(p.isRelative(event.path) ? event.path : p.relative(event.path, from: dir.path))) {
              print("File ${event.path} changed. Recompiling...");
              await recompile(client, entrypoint); 
            }                 
        }
      } finally {
        clientActive = false;
      }
    }
  });

  return DartDevClientResult._(client: client, dartSdk: dartSdk(dir.path));
}

/// Terminates the dartdevc frontend client
void terminateClient(DartDevcFrontendServerClient client, {required bool error}) async {
  // shutdown client
  await client.shutdown();

  // exit
  exit(error ? 1 : 0);
}

Future<void> recompile(DartDevcFrontendServerClient client, String entrypoint) async {
  final result = await client.compile([Uri.parse('org-dartlang-root:///$entrypoint')]);
  if (result.errorCount > 0) {
    print("Error compiling project: \n${result.compilerOutputLines.join('\n')}");
    client.reject();
  } else {
    client.accept();
    // TODO: Add hmr
    print("Reload app to see change");
  } 
}

class DartDevClientResult extends DartClientResult {
  final DartDevcFrontendServerClient client;

  /// Relative path to the dart SDK
  final String dartSdk;

  DartDevClientResult._({
    required this.client,
    this.dartSdk = '.dart_tool/out/dart_sdk.js'
  });
}