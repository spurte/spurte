// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dyte/src/api/plugin.dart';
import 'package:dyte/src/config/dyte_config.dart';

class DyteApp {
  List<DytePlugin> plugins;
  DyteConfig config;

  DyteApp({
    this.plugins = const [],
    this.config = const DyteConfig()
  });
}

enum DyteKind {
  Import,
}

class DyteResolveOptions {
  final String name;
  final String path;
  final DyteKind kind;

  DyteResolveOptions({
    required this.name,
    required this.path,
    this.kind = DyteKind.Import
  });
}

typedef DyteSetup = FutureOr<DyteApp> Function(DyteApp app);
typedef DyteTeardown = FutureOr<DyteApp> Function(DyteApp app);

typedef DyteResolve = String? Function(DyteResolveOptions id);
typedef DyteLoad = DytePluginResult Function(String id, String source, [DyteResolveOptions? options]);

typedef DyteBeforeLoad = void Function(DyteResolveOptions id);
typedef DyteAfterLoad = void Function(DyteResolveOptions id);
