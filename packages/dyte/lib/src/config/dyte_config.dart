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

  /// The main entrypoint to the dyte project
  /// 
  /// Since Dart is a compiled language that makes use of a main function, an entrypoint can be specified relative to the project.
  /// 
  /// Defaults to `web/main.dart` or `web/index.dart` if the former isn't there.
  final String? entry;

  /// Explicitly set the mode and overwrite the default mode or mode passed via the command line.
  final DyteMode? mode;

  /// The list of plugins provided for this project, either as a file path or as a package uri
  final Iterable<String>? plugins;

  /// The path to the pubspec.yaml file. Defaults to the pubspec.yaml file located at the [root] of the directory
  final String? pubspec;

  /// Development options, used for customizing development as well as for other dev options.
  /// 
  /// For options to customize the dev server, see the [server] field, or [DyteServerOptions] for more information. 
  final DyteDevOptions? dev;

  /// Options for customizing building the project
  final DyteBuildOptions? build;

  /// Configure the server options for Dyte's development server
  final DyteServerOptions? server;

  /// The logging level for the dyte server
  final DyteLogLevel? logLevel;

  /// Whether hot module replacement is active on the given project
  ///
  /// Defaults to true
  final bool? hmr;

  /// Options used for configuring the use of JavaScript projects and dependencies in the Dyte Project
  final DyteJSOptions? js;

  /// Experimental options
  final DyteExperimentalOptions? experimental;

  /// ?
  final bool? multiPackages;

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
      this.hmr,
      this.entry});

  factory DyteConfig.fromJson(Map<String, dynamic> json) => _$DyteConfigFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteConfigToJson(this);
  // WAIGen Options
}

class DyteExperimentalOptions {
    /// Whether to add types to the bundled JS files
  /// 
  /// This option defaults to `false`, but if [bundleAsJs] is provided as `false`, this option is ignored.
  /// 
  /// > **NOTE**: This option is experimental, and doesn't work at the moment
  final bool? bundleWithTypes;

  DyteExperimentalOptions({
    this.bundleWithTypes
  });

  factory DyteExperimentalOptions.fromJson(Map<String, dynamic> json) => DyteExperimentalOptions();

  // Dartpack Options
  Map<String, dynamic> toJson() => {};
}

@JsonSerializable()
class DyteServerOptions {
  /// The server port number. Defaults to 8000
  final int? port;

  /// The server hostname. Defaults to "localhost"
  final String? host;

  /// HTTPS information that, when provided, can be used for creating a https server
  final DyteServerHttpsOptions? https;

  DyteServerOptions({this.port, this.host, this.https});

  factory DyteServerOptions.fromJson(Map<String, dynamic> json) => _$DyteServerOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$DyteServerOptionsToJson(this);
}

@JsonSerializable()
class DyteServerHttpsOptions {
  /// The path to the https certificate used for creating the https server
  String? cert;

  /// The path to the https key used for creating the https server
  String? key;

  DyteServerHttpsOptions({ this.cert, this.key });

  factory DyteServerHttpsOptions.fromJson(Map<String, dynamic> json) => _$DyteServerHttpsOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteServerHttpsOptionsToJson(this);
}

@JsonSerializable()
class DyteDevOptions {
  /// Whether to bundle external dependencies or import them as-is.
  /// 
  /// Defaults to true, meaning url dependencies are bundled.
  final bool? bundleJsDeps;

  /// Whether to initiate a full reload upon receiving changes
  /// 
  /// Defaults to false
  final bool? fullReload;

  DyteDevOptions({this.bundleJsDeps, this.fullReload});

  factory DyteDevOptions.fromJson(Map<String, dynamic> json) => _$DyteDevOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteDevOptionsToJson(this);
}

@JsonSerializable()
class DyteBuildOptions {
  /// The output directory for the build files
  /// 
  /// Defaults to the `dist/` directory
  final String? outdir;

  /// Whether to bundle the project with JS
  /// 
  /// Defaults to `true`
  final bool? bundleAsJs;

  /// Whether to minify output
  /// 
  /// Defaults to `true`
  final bool? minify;

  DyteBuildOptions({this.outdir, this.bundleAsJs, this.minify});

  factory DyteBuildOptions.fromJson(Map<String, dynamic> json) => _$DyteBuildOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$DyteBuildOptionsToJson(this);
}

@JsonSerializable()
class DyteJSOptions {
  /// Whether typescript is being used in this project
  final bool? typescript;

  /// Whether JSX is being used in this project
  final bool? jsx;

  /// Whether to make use of a `node_modules` directory
  final bool? nodeModulesDir;

  /// The package manager used to install the node modules, if any.
  ///
  /// This defaults to "npm"
  /// 
  /// if `nodeModulesDir` is undefined or false, this option is ignored.
  final DyteJSPackageManager? packageManager;

  /// The CDN to use to cache NPM dependencies during development.
  /// Defaults to undefined for Dyte's own NPM dependency management.
  ///
  /// if `nodeModulesDir` is true, this option is ignored
  final String? cdn;

  /// Whether deno is used in the given project
  ///
  /// If not defined, this can be inferred through the use of a `deno.json` file in the project
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
