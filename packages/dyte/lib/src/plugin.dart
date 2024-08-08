
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

Future<bool> runPlugins(List<String> plugins, Directory dir, {String config = "dyte.config.json"}) async {
  final dartTool = Directory(p.join(dir.absolute.path, '.dart_tool'));

  final dytePluginFile = await File(p.join(dartTool.path, 'dyte', 'plugin.dart')).create(recursive: true);
  // create isolate file for all plugins
  final dytePluginFileContent = '''${plugins.map((e) {
    // check if is relative path and resolve relative to where the file is
    final isRelativeUri = !(e.startsWith('package:')) && p.isRelative(e);
    final fullPath = isRelativeUri ? p.relative(p.join(dir.path, e), from: p.dirname(dytePluginFile.path)) : e;

    // Return import statement
    return 'import "$fullPath" as _i${plugins.indexOf(e)};';
  }).join("\n")}
import 'package:dyte/build.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

void main(_, SendPort port) async {
  final config = json.decode(File("$config").readAsStringSync());
  var app = DyteApp(
    plugins: [${plugins.map((e) => '_i${plugins.indexOf(e)}.plugin').join(", ")}],
    config: DyteConfig.fromJson(config)
  );

  final plugins = [${plugins.map((e) => '_i${plugins.indexOf(e)}.plugin').join(", ")}];

  // TODO: Optimize
  try {
    for (final plugin in plugins) {
      app = await resolve(plugin, "${dir.absolute.path}", app: app);
    }
    port.send("Done!");
  } catch (e) {
    port.send("Error: \$e");
  }
}
''';

  // import plugin runner
  await dytePluginFile.writeAsString(dytePluginFileContent);

  // run plugins from file
  final port = ReceivePort();

  await Isolate.spawnUri(dytePluginFile.uri, [], port.sendPort);

  final String response = (await port.first) as String;
  
  if (response.startsWith("Done!")) {
    return true;
  } else {
    throw Exception("Error resolving plugins: $response");
  }
}