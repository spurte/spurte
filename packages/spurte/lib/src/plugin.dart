import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:io/ansi.dart';
import 'package:path/path.dart' as p;

class PluginSystem {
  Isolate _isolate;
  Stream _port;
  ReceivePort _exitPort;
  SendPort? _communicationPort;
  Map<String, List<String>> _pluginMap;

  bool? success;
  final StreamController _events = StreamController.broadcast();

  PluginSystem._(Isolate isolate, Stream port, ReceivePort exitPort, {SendPort? commPort, Map<String, List<String>>? pluginMap}): 
    _isolate = isolate, _port = port, _exitPort = exitPort, _communicationPort = commPort, _pluginMap = pluginMap ?? {} {
      port.asBroadcastStream().listen((d) {
        _events.add(d);
      });
    }

  static Future<PluginSystem> start(File pluginFile, List<String> plugins) async {
    final port = ReceivePort();
    final exitPort = ReceivePort();
    SendPort? commPort;

    try {
      final isolate = await Isolate.spawnUri(pluginFile.uri, [], port.sendPort, onExit: exitPort.sendPort);

    final Map<String, List<String>> pluginResolve = {};
    final portStr = port.asBroadcastStream();
    StreamSubscription? sub;
    StreamSubscription? sub2;

    sub = portStr.map((m) => PluginResolveResult.fromJson(m)).listen((d) {
      if (d.all == true) {
        if (d.success) { /* Handle success */ sub?.cancel(); }
        else { /* Handle error */ }
      } else {
        if (!d.success) {
          throw Exception('Could not resolve plugins: ${d.error}');
        }
        pluginResolve[d.plugin!] = d.files!;
      }
    });

    sub2 = portStr.listen((e) {
      final event = e as Map<String, dynamic>;
      if (event.containsKey('port')) {
        commPort = event['port'] as SendPort?;
      }
    });

    return PluginSystem._(isolate, portStr, exitPort, pluginMap: pluginResolve, commPort: commPort);
    } on Exception catch (e) {
      stderr.writeAll([red.wrap("Error instantiating plugin system: "), e.toString()]);
      rethrow;
    }
    
  }

  Future<bool> rerun(String path) async {
    if (_communicationPort == null) return false;

    final pluginEntries = _pluginMap.entries.where((entry) => entry.value.contains(path));
    if (pluginEntries.isEmpty) return true;

    var listener;
    final entry = pluginEntries.first;
    // TODO: run plugin to focus on particular file rather than all files
    _communicationPort?.send({
      'plugin': entry.key,
    });
    listener = _events.stream.map((m) => PluginResolveResult.fromJson(m)).listen((e) {
      if (e.success) {
        // handle success
      } else {
        // handle failure
      }
    });

    return true;
  }
}

class PluginResolveResult {
  bool success;
  bool? all;
  String? plugin;
  List<String>? files;
  Object? error;

  PluginResolveResult({
    required this.success,
    this.files,
    this.error,
    this.all,
    this.plugin
  });

  factory PluginResolveResult.fromJson(Map<String, dynamic> json) => PluginResolveResult(
    success: json['success'], 
    files: json['files'] ?? [], 
    error: json['error'],
    all: json['all'],
    plugin: json['plugin']
  );
}

Future<PluginSystem> createPluginWatcher(List<String> plugins, Directory dir,
    {String config = "spurte.config.json", bool dev = false}) async {
  final dartTool = Directory(p.join(dir.absolute.path, '.dart_tool'));

  final spurtePluginFile =
      await File(p.join(dartTool.path, 'spurte', 'plugin.dart'))
          .create(recursive: true);
  // create isolate file for all plugins
  final spurtePluginFileContent = '''${plugins.map((e) {
    // check if is relative path and resolve relative to where the file is
    final isRelativeUri = !(e.startsWith('package:')) && p.isRelative(e);
    final fullPath = isRelativeUri
        ? p.relative(p.join(dir.path, e),
            from: p.dirname(spurtePluginFile.path))
        : e;

    // Return import statement
    return 'import "$fullPath" as _i${plugins.indexOf(e)};';
  }).join("\n")}
import 'package:spurte/build.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

void main(_, SendPort port) async {
  final config = json.decode(File("$config").readAsStringSync());
  var app = SpurteApp(
    plugins: [${plugins.map((e) => '_i${plugins.indexOf(e)}.plugin').join(", ")}],
    config: SpurteConfig.fromJson(config)
  );

  final plugins = [${plugins.map((e) => '_i${plugins.indexOf(e)}.plugin').join(", ")}];

  // TODO: Optimize
  try {
    for (final plugin in plugins) {
      app = await resolve(plugin, "${dir.absolute.path}", app: app, dev: $dev);
      port.send({
        'plugin': plugin.name ?? 'unnamed\${plugins.indexOf(plugin)}',
        'success': true,
        'files': affectedPaths(plugin, "${dir.absolute.path}", app: app, dev: $dev)
      });
    }
    port.send({
      'all': true,
      'success': true,
    });
  } catch (e) {
    port.send({
      'success': false,
      'error': e.toString()
    });
  }

  // send back port for bidirectional communication
  if ($dev) {
    final commPort = ReceivePort();
    port.send({
      'port': commPort.sendPort
    });

    commPort.listen((e) async {
      final event = e as Map<String, dynamic>;
      final p = plugins.singleWhere((e) => e.name == event['plugin']);
      app = await resolve(p, "${dir.absolute.path}", app: app, dev: $dev);
      port.send({
        'plugin': p.name ?? 'unnamed\${plugins.indexOf(p)}',
        'success': true,
        'files': affectedPaths(p, "${dir.absolute.path}", app: app, dev: $dev)
      });
    });
  }
  // while (true) {
    
  // }
}
''';

  // import plugin runner
  await spurtePluginFile.writeAsString(spurtePluginFileContent);

  return await PluginSystem.start(spurtePluginFile, plugins);
}
