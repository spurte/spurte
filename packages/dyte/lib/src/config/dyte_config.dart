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
  final String? root;
  final String? base;
  final String? publicDir;
  final String? publicRoot;
  final String? pubspec;
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

  DyteConfig(
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
      this.hmr});

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
