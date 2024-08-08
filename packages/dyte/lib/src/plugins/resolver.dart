import 'dart:io';

import 'plugins.dart';

import '../api/plugin.dart';

import 'package:path/path.dart' as p;

Future<DyteApp> resolve(DytePlugin plugin, String dir, {required DyteApp app}) async {
  final directory = Directory(dir);
  // perform setup
  /* DEBUG */ print("SETUP");
  var main = await (plugin.setup ?? (app) => app)(app);

  // perform resolving and loading
  final Map<String?, List<DyteResolveOptions>> resolved = {};

  await for (final fse in directory.list(recursive: true)) {
    if (fse is! File) {
      continue;
    } else {
      final opt = DyteResolveOptions(
        name: p.basename(fse.path), 
        path: fse.absolute.path, 
        kind: DyteKind.File
      );
      /* DEBUG */ print("RESOLVE ${fse.path}");
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
      /* DEBUG */ print("BEFORE LOAD ${v.path}");
      (plugin.beforeLoad ?? (id) {})(v);

      // perform load
      /* DEBUG */ print("LOAD");
      final content = File(v.path).readAsStringSync();
      final result = (plugin.load ?? (id, source, [options]) {
        return DytePluginResult(
          path: v.path,
          src: content
        );
      })(id, content, v);

      if (result.path != null) {
        File(result.path!).writeAsStringSync(result.src ?? "");
      }

      // perform after load
      /* DEBUG */ print("AFTER LOAD ${result.path}");
      (plugin.afterLoad ?? (id) {})(v);
    }
  }

  // perform teardown
  /* DEBUG */ print("TEARDOWN");
  main = await (plugin.teardown ?? (app) => app)(app);

  // return app to be used in next run
  /* DEBUG */ print("DONE");
  return main;
}