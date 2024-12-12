import 'dart:io';

import 'plugins.dart';

import '../api/plugin.dart';

import 'package:path/path.dart' as p;

Future<SpurteApp> resolve(SpurtePlugin plugin, String dir, {required SpurteApp app, bool dev = false}) async {
  final directory = Directory(dir);
  // perform setup
  var main = await (plugin.setup ?? (app) => app)(app);

  // perform resolving and loading
  final Map<String?, List<SpurteResolveOptions>> resolved = {};

  await for (final fse in directory.list(recursive: true)) {
    if (fse is! File) {
      continue;
    } else {
      final opt = SpurteResolveOptions(
        name: p.basename(fse.path), 
        path: fse.absolute.path, 
        kind: SpurteKind.File,
        dev: dev
      );

      final id = (plugin.resolve ?? (opt) => null)(opt);
      if (resolved.keys.contains(id)) {
        resolved[id]?.add(opt);
      } else {
        resolved[id] = [opt];
      }
    }
  }

  // TODO: Optimize
  for (final opt in resolved.entries) {
    final id = opt.key;
    if (id == null) continue;

    for (final v in opt.value) {
      // perform before load
      (plugin.beforeLoad ?? (id) {})(v);

      // perform load
      final content = File(v.path).readAsStringSync();
      final result = (plugin.load ?? (id, source, [options]) {
        return SpurtePluginResult(
          path: v.path,
          src: content
        );
      })(id, content, v);

      if (result.path != null) {
        Directory(p.dirname(result.path ?? '')).createSync(recursive: true);
        File(result.path!).writeAsStringSync(result.src ?? "");
      }

      // perform after load
      (plugin.afterLoad ?? (id) {})(v);
    }
  }

  // perform teardown
  main = await (plugin.teardown ?? (app) => app)(app);

  // return app to be used in next run
  return main;
}