
import 'dart:io';

import 'package:path/path.dart' as p;

runPlugins(List<String> plugins, Directory dir, {String config = "dyte.config.json"}) async {
  final dartTool = Directory(p.join(dir.path, '.dart_tool'));

  final dytePluginFile = await File(p.join(dartTool.path, 'dyte', 'plugin.dart')).create();
  // create isolate file for all plugins
  final dytePluginFileContent = '''${plugins.map((e) => 'import "$e" as _i${plugins.indexOf(e)};').join("\n")}
import 'package:dyte/build.dart';

import 'dart:convert';
import 'dart:io';

void main(_, SendPort port) {
  final config = json.decode(File("$config").readAsStringSync());
  final app = DyteApp(
    plugins: $plugins
    config: DyteConfig.fromJson(config)
  );

  final plugins = [${plugins.map((e) => '_i${plugins.indexOf(e)}').join(", ")}];

  for (final plugin of plugins) {
    resolve(plugin);
  }
}
''';

  // import plugin runner

  // run plugins from file
}