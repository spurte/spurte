/// TODO: Add more documentation
// ignore_for_file: constant_identifier_names

import 'dart:async';

import '../api/plugin.dart';
import '../config/config.dart';

class SpurteApp {
  List<SpurtePlugin> plugins;
  SpurteConfig config;

  SpurteApp({this.plugins = const [], required this.config});
}

enum SpurteKind { Import, File }

class SpurteResolveOptions {
  final String name;
  final String path;
  final SpurteKind kind;

  /// Whether this is a development build of the application or not
  final bool dev;

  SpurteResolveOptions(
      {required this.name,
      required this.path,
      this.dev = false,
      this.kind = SpurteKind.Import});
}

typedef SpurteSetup = FutureOr<SpurteApp> Function(SpurteApp app);
typedef SpurteTeardown = FutureOr<SpurteApp> Function(SpurteApp app);

typedef SpurteResolve = String? Function(SpurteResolveOptions id);
typedef SpurteLoad = SpurtePluginResult Function(String id, String source,
    [SpurteResolveOptions? options]);

typedef SpurteBeforeLoad = void Function(SpurteResolveOptions id);
typedef SpurteAfterLoad = void Function(SpurteResolveOptions id);
