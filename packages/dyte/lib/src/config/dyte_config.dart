import 'package:json_annotation/json_annotation.dart';

part 'dyte_config.g.dart';

/// The configuration for a Dyte project, usually gotten from a Dyte config file (`dyte.config.dart` or `.dyterc`), that is used to configure the default behaviour of a Dyte project.
///
/// The Dyte Configuration is used for configuring major behaviours in the Dyte Server:
/// The options used for running main dyte tasks like starting the dev server,
/// Configuring module resolution during build and development,
/// Resolving Dart and JS Modules, as well as interop between them.
///
/// ```dart
/// import 'package:dyte/dyte.dart';
///
/// // Dyte Configuration in a dyte.config.dart file
/// var config = defineConfig(
/// 	// define configuration here
/// );
/// ```
@JsonSerializable()
class DyteConfig {
  /// The root of the dyte project. Defaults to the current working directory
  final String? root;

  /// The base url of the dyte project.
  final String? base;

  /// The public directory to use for serving public assets. Defaults to `public/`
  final String? publicDir;

  /// The base url to serve public assets at. Defaults to `/`
  final String? publicRoot;

  /// The path to the pubspec.yaml file. Defaults to the pubspec.yaml file located at the [root] of the directory
  final String? pubspec;

  /// The main entrypoint to the dyte project
  /// 
  /// Since Dart is a compiled language that makes use of a main function, an entrypoint can be specified relative to the project.
  /// 
  /// Defaults to `web/main.dart` or `web/index.dart` if the former isn't there.
  final String? entry;
  final DyteDevOptions? dev;
  final DyteBuildOptions? build;
  final DyteServerOptions? server;
  final Iterable<String>? plugins;
  final DyteJSOptions? js;
  final DyteMode? mode;
  final DyteLogLevel? logLevel;
  final DyteExperimentalOptions? experimental;
  final bool? multiPackages;
  final bool? hmr;

  const DyteConfig(
      {this.root,
      this.base,
      this.publicDir,
      this.publicRoot,
      this.pubspec,
      this.dev,
      this.build,
      this.server,
      this.plugins,
      this.js,
      this.mode,
      this.logLevel,
      this.experimental,
      this.multiPackages,
      this.hmr,
      this.entry});

  factory DyteConfig.fromJson(Map<String, dynamic> json) => _$DyteConfigFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteConfigToJson(this);
  // WAIGen Options
}

class DyteExperimentalOptions {
  DyteExperimentalOptions();

  factory DyteExperimentalOptions.fromJson(Map<String, dynamic> json) => DyteExperimentalOptions();

  // Dartpack Options
  Map<String, dynamic> toJson() => {};
}

@JsonSerializable()
class DyteServerOptions {
  final int? port;
  final String? host;
  final DyteServerHttpsOptions? https;

  DyteServerOptions({this.port, this.host, this.https});

  factory DyteServerOptions.fromJson(Map<String, dynamic> json) => _$DyteServerOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteServerOptionsToJson(this);
}

@JsonSerializable()
class DyteServerHttpsOptions {
  String? cert;
  String? key;

  DyteServerHttpsOptions({ this.cert, this.key });

  factory DyteServerHttpsOptions.fromJson(Map<String, dynamic> json) => _$DyteServerHttpsOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteServerHttpsOptionsToJson(this);
}

@JsonSerializable()
class DyteDevOptions {
  final bool? bundleJsDeps;
  final bool? fullReload;

  DyteDevOptions({this.bundleJsDeps, this.fullReload});

  factory DyteDevOptions.fromJson(Map<String, dynamic> json) => _$DyteDevOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteDevOptionsToJson(this);
}

@JsonSerializable()
class DyteBuildOptions {
  final String? outdir;
  final bool? bundleAsJs;
  final bool? bundleWithTypes;

  DyteBuildOptions({this.outdir, this.bundleAsJs, this.bundleWithTypes});

  factory DyteBuildOptions.fromJson(Map<String, dynamic> json) => _$DyteBuildOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteBuildOptionsToJson(this);
}

@JsonSerializable()
class DyteJSOptions {
  final bool? typescript;
  final bool? jsx;

  final bool? nodeModulesDir;
  final DyteJSPackageManager? packageManager;
  final String? cdn;
  final bool? deno;

  DyteJSOptions(
      {this.typescript,
      this.jsx,
      this.nodeModulesDir,
      this.packageManager,
      this.cdn,
      this.deno});

  // JSIGen Options

  factory DyteJSOptions.fromJson(Map<String, dynamic> json) => _$DyteJSOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteJSOptionsToJson(this);
}

@JsonEnum(valueField: 'packageManager')
enum DyteJSPackageManager {
  npm('npm'),
  pnpm('pnpm'),
  yarn('yarn'),
  bun('bun');

  const DyteJSPackageManager(this.packageManager);
  final String packageManager;
}

@JsonEnum(valueField: 'mode')
enum DyteMode {
  development('development'),
  production('production');

  const DyteMode(this.mode);
  final String mode;
}

@JsonEnum(valueField: 'logLevel')
enum DyteLogLevel {
  debug('debug'),
  info('info'),
  warn('warn'),
  error('error'),
  none('none');

  const DyteLogLevel(this.logLevel);
  final String logLevel;
}
