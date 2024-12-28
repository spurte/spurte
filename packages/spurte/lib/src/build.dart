import 'dart:async';
import 'dart:io';

import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;

import 'options/build_options.dart';
import 'build/wasm_entry.dart';

class DartBuilderResult {
  final Map<String, String> packages;
  final Map<String, String> otherFiles;

  const DartBuilderResult._({
    // ignore: unused_element
    this.otherFiles = const {},
    this.packages = const {},
  });
}

abstract class DartBuilder {
  String get exec;

  List<String> get args;

  /// [entrypoint] must be a relative path from the project directory specified in [options] ([BuildOptions.cwd])
  FutureOr<DartBuilderResult> build(String entrypoint, BuildOptions options);
}

class DartJSBuilder implements DartBuilder {
  @override
  Future<DartBuilderResult> build(
      String entrypoint, BuildOptions options) async {
    final addArgs = [
      "--multi-root-scheme=org-dartlang-sdk",
      "--packages=${p.join(options.cwd, '.dart_tool', 'package_config.json')}",
      if (options.minify) '-O2',
      '-o${p.join(options.dist, p.basename(entrypoint))}.js',
      entrypoint
    ];

    final packageConfig = await findPackageConfig(Directory(options.cwd));
    final packages = packageConfig?.packages ?? [];
    final pkgMap = {for (var e in packages) e.name: '/packages/${e.name}'};

    // compile project
    final result = await Process.run(exec, [...args, ...addArgs],
        workingDirectory: options.cwd);

    if (result.exitCode != 0) {
      print(
          "Failed to compile the program: \n${result.stdout}\n${result.stderr}");
      exit(result.exitCode);
    }

    // post build process
    if (!options.verbose) {
      await File(p.join(
              options.cwd, options.dist, '${p.basename(entrypoint)}.js.deps'))
          .delete();
      await File(p.join(
              options.cwd, options.dist, '${p.basename(entrypoint)}.js.map'))
          .delete();
    }

    return DartBuilderResult._(packages: pkgMap);
  }

  @override
  List<String> get args => ["compile", "js"];

  @override
  String get exec => Platform.executable;
}

class DartWasmBuilder implements DartBuilder {
  @override
  List<String> get args => ["compile", "wasm"];

  @override
  String get exec => Platform.executable;

  @override
  Future<DartBuilderResult> build(
      String entrypoint, BuildOptions options) async {
    final addArgs = [
      "--packages=${p.join(options.cwd, '.dart_tool', 'package_config.json')}",
      if (options.minify) '-O2',
      '-o${p.join(options.dist, p.basename(entrypoint))}.js',
      entrypoint
    ];

    final packageConfig = await findPackageConfig(Directory(options.cwd));
    final packages = packageConfig?.packages ?? [];
    final pkgMap = {for (var e in packages) e.name: '/packages/${e.name}'};

    final result = await Process.run(exec, [...args, ...addArgs],
        workingDirectory: options.cwd);

    if (result.exitCode != 0) {
      print(
          "Failed to compile the program: \n${result.stdout}\n${result.stderr}");
      exit(result.exitCode);
    }

    // post build
    await writeWasm(
        p.basenameWithoutExtension(entrypoint),
        Directory(p.join(options.cwd, options.dist)),
        options.importFile,
        options.exportFile);

    return DartBuilderResult._(packages: pkgMap);
  }
}

Future<void> build(BuildOptions options) async {
  // get entrypoint
  final entrypoints = options.entrypoints;
  final builder = options.wasm ? DartWasmBuilder() : DartJSBuilder();
  DartBuilderResult b;
  bool bInit = false;

  // cleanup previous builds
  var buildDirectory = Directory(p.join(options.cwd, options.dist));
  if (buildDirectory.existsSync()) {
    await buildDirectory.delete(recursive: true);
  }

  // build entrypoint
  for (String e in entrypoints) {
    b = await builder.build(e, options);
    if (!bInit) {
      bInit = true;
      File(p.join(options.cwd, options.dist, '.packages')).writeAsStringSync(
          b.packages.entries.map((e) => "${e.key}:${e.value}").join("\n"));
    }
  }

  // copy html file
  var indexPath = p.isRelative(options.index)
      ? p.join(options.cwd, options.index)
      : options.index;
  var index = await File(indexPath).readAsString();

  index = index.replaceAll('web/', '/');
  File(p.join(
          options.cwd, options.dist, p.relative(indexPath, from: options.cwd)))
      .writeAsString(index);

  // copy all public assets in the public directory at the root of the directory
  final publicDir = Directory(p.join(options.cwd, options.publicDir));

  if (await publicDir.exists()) {
    await for (final publicFile in publicDir.list(recursive: true)) {
      if (publicFile is File) {
        var substring =
            options.publicRoot.substring(0, options.publicRoot.length);
        await publicFile.copy(p.join(
            options.cwd,
            options.dist,
            substring == "" || substring == "/" ? "." : substring,
            p.relative(publicFile.absolute.path,
                from: p.join(options.cwd, options.publicDir))));
      }
    }
  }

  print("Build written to ${options.dist}");
}
