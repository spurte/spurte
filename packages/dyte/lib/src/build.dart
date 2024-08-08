import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;

class BuildOptions {
  final bool wasm;
  final bool minify;
  final String cwd;
  final String dist;

  const BuildOptions({
    this.wasm = false,
    this.minify = true,
    required this.cwd,
    this.dist = "dist",
  });
}

class DartBuilderResult {
  final String output;
  final Map<String, String> packages;
  final Map<String, String> otherFiles;

  const DartBuilderResult._({
    required this.output,
    this.packages = const {},
    this.otherFiles = const {},
  });
}

abstract class DartBuilder {
  String get exec;

  List<String> get args;
  
  FutureOr<void> build(String entrypoint, BuildOptions options);
}

class DartJSBuilder implements DartBuilder {
  @override
  void build(String entrypoint, BuildOptions options) async {
    final addArgs = ["--multi-root-scheme=org-dartlang-sdk", "--packages=${p.join(options.cwd, '.dart_tool', 'package_config.json')}"];
    if (options.minify) addArgs.add('--O2');
    addArgs.addAll(['-o${p.join(options.dist, p.basename(entrypoint))}.js', entrypoint]);

    final result = await Process.run(exec, [...args, ...addArgs], workingDirectory: options.cwd);

    if (result.exitCode != 0) {
      print("Failed to compile the dart sdk: \n${result.stdout}\n${result.stderr}");
      exit(result.exitCode);
    }
  }
  
  @override
  List<String> get args => ["compile", "js"];
  
  @override
  String get exec => Platform.executable;
}

class DartWasmBuilder implements DartBuilder {
  @override
  List<String> get args => ["compile", "js"];
  
  @override
  String get exec => Platform.executable;

  @override
  void build(String entrypoint, BuildOptions options) async {
    final addArgs = ["--multi-root-scheme=org-dartlang-sdk", "--packages=${p.join(options.cwd, '.dart_tool', 'package_config.json')}"];
    if (options.minify) addArgs.add('--O2');
    addArgs.addAll(['-o${p.join(options.dist, p.basename(entrypoint))}.js', entrypoint]);

    final result = await Process.run(exec, [...args, ...addArgs], workingDirectory: options.cwd);

    if (result.exitCode != 0) {
      print("Failed to compile the dart sdk: \n${result.stdout}\n${result.stderr}");
      exit(result.exitCode);
    }
  }
}

build(BuildOptions options) {
  // get entrypoint

  // build entrypoint

  // copy html file 

  // copy all public assets in the public directory at the root of the directory
}