// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:spurte/src/api/plugin.dart';
import 'package:spurte/src/config/spurte_config.dart';

class SpurteApp {
  List<SpurtePlugin> plugins;
  SpurteConfig config;

  SpurteApp({
    this.plugins = const [],
    this.config = const SpurteConfig()
  });
}

enum SpurteKind {
  Import, File
}

class SpurteResolveOptions {
  final String name;
  final String path;
  final SpurteKind kind;

  SpurteResolveOptions({
    required this.name,
    required this.path,
    this.kind = SpurteKind.Import
  });
}

typedef SpurteSetup = FutureOr<SpurteApp> Function(SpurteApp app);
typedef SpurteTeardown = FutureOr<SpurteApp> Function(SpurteApp app);

typedef SpurteResolve = String? Function(SpurteResolveOptions id);
typedef SpurteLoad = SpurtePluginResult Function(String id, String source, [SpurteResolveOptions? options]);

typedef SpurteBeforeLoad = void Function(SpurteResolveOptions id);
typedef SpurteAfterLoad = void Function(SpurteResolveOptions id);
