import 'package:json_annotation/json_annotation.dart';

part 'spurte_config.g.dart';

/// The configuration for a Spurte project, usually gotten from a Spurte config file (`spurte.config.dart` or `.spurterc`), that is used to configure the default behaviour of a Spurte project.
///
/// The Spurte Configuration is used for configuring major behaviours in the Spurte Server:
/// The options used for running main spurte tasks like starting the dev server,
/// Configuring module resolution during build and development,
/// Resolving Dart and JS Modules, as well as interop between them.
///
/// ```dart
/// import 'package:spurte/spurte.dart';
///
/// // Spurte Configuration in a spurte.config.dart file
/// var config = defineConfig(
/// 	// define configuration here
/// );
/// ```
@JsonSerializable()
class SpurteConfig {
  /// The root of the spurte project. Defaults to the current working directory
  final String? root;

  /// The base url of the spurte project.
  final String? base;

  /// The public directory to use for serving public assets. Defaults to `public/`
  final String? publicDir;

  /// The base url to serve public assets at. Defaults to `/`
  final String? publicRoot;

  /// The main entrypoint to the spurte project
  /// 
  /// Since Dart is a compiled language that makes use of a main function, an entrypoint can be specified relative to the project.
  /// 
  /// Defaults to `web/main.dart` or `web/index.dart` if the former isn't there.
  final String? entry;

  /// Explicitly set the mode and overwrite the default mode or mode passed via the command line.
  final SpurteMode? mode;

  /// The list of plugins provided for this project, either as a file path or as a package uri
  final Iterable<String>? plugins;

  /// The path to the pubspec.yaml file. Defaults to the pubspec.yaml file located at the [root] of the directory
  final String? pubspec;

  /// Development options, used for customizing development as well as for other dev options.
  /// 
  /// For options to customize the dev server, see the [server] field, or [SpurteServerOptions] for more information. 
  final SpurteDevOptions? dev;

  /// Options for customizing building the project
  final SpurteBuildOptions? build;

  /// Configure the server options for Spurte's development server
  final SpurteServerOptions? server;

  /// The logging level for the spurte server
  final SpurteLogLevel? logLevel;

  /// Whether hot module replacement is active on the given project
  ///
  /// Defaults to true
  final bool? hmr;

  /// Options used for configuring the use of JavaScript projects and dependencies in the Spurte Project
  final SpurteJSOptions? js;

  /// Experimental options
  final SpurteExperimentalOptions? experimental;

  /// ?
  final bool? multiPackages;

  const SpurteConfig(
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

  factory SpurteConfig.fromJson(Map<String, dynamic> json) => _$SpurteConfigFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$SpurteConfigToJson(this);
  // WAIGen Options
}

class SpurteExperimentalOptions {
    /// Whether to add types to the bundled JS files
  /// 
  /// This option defaults to `false`, but if [bundleAsJs] is provided as `false`, this option is ignored.
  /// 
  /// > **NOTE**: This option is experimental, and doesn't work at the moment
  final bool? bundleWithTypes;

  SpurteExperimentalOptions({
    this.bundleWithTypes
  });

  factory SpurteExperimentalOptions.fromJson(Map<String, dynamic> json) => SpurteExperimentalOptions();

  // Dartpack Options
  Map<String, dynamic> toJson() => {};
}

@JsonSerializable()
class SpurteServerOptions {
  /// The server port number. Defaults to 8000
  final int? port;

  /// The server hostname. Defaults to "localhost"
  final String? host;

  /// HTTPS information that, when provided, can be used for creating a https server
  final SpurteServerHttpsOptions? https;

  SpurteServerOptions({this.port, this.host, this.https});

  factory SpurteServerOptions.fromJson(Map<String, dynamic> json) => _$SpurteServerOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$SpurteServerOptionsToJson(this);
}

@JsonSerializable()
class SpurteServerHttpsOptions {
  /// The path to the https certificate used for creating the https server
  String? cert;

  /// The path to the https key used for creating the https server
  String? key;

  SpurteServerHttpsOptions({ this.cert, this.key });

  factory SpurteServerHttpsOptions.fromJson(Map<String, dynamic> json) => _$SpurteServerHttpsOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$SpurteServerHttpsOptionsToJson(this);
}

@JsonSerializable()
class SpurteDevOptions {
  /// Whether to bundle external dependencies or import them as-is.
  /// 
  /// Defaults to true, meaning url dependencies are bundled.
  final bool? bundleJsDeps;

  /// Whether to initiate a full reload upon receiving changes
  /// 
  /// Defaults to false
  final bool? fullReload;

  SpurteDevOptions({this.bundleJsDeps, this.fullReload});

  factory SpurteDevOptions.fromJson(Map<String, dynamic> json) => _$SpurteDevOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$SpurteDevOptionsToJson(this);
}

@JsonSerializable()
class SpurteBuildOptions {
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

  SpurteBuildOptions({this.outdir, this.bundleAsJs, this.minify});

  factory SpurteBuildOptions.fromJson(Map<String, dynamic> json) => _$SpurteBuildOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$SpurteBuildOptionsToJson(this);
}

@JsonSerializable()
class SpurteJSOptions {
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
  final SpurteJSPackageManager? packageManager;

  /// The CDN to use to cache NPM dependencies during development.
  /// Defaults to undefined for Spurte's own NPM dependency management.
  ///
  /// if `nodeModulesDir` is true, this option is ignored
  final String? cdn;

  /// Whether deno is used in the given project
  ///
  /// If not defined, this can be inferred through the use of a `deno.json` file in the project
  final bool? deno;

  SpurteJSOptions(
      {this.typescript,
      this.jsx,
      this.nodeModulesDir,
      this.packageManager,
      this.cdn,
      this.deno});

  // JSIGen Options

  factory SpurteJSOptions.fromJson(Map<String, dynamic> json) => _$SpurteJSOptionsFromJson(json);

  // Dartpack Options
  Map<String, dynamic> toJson() => _$SpurteJSOptionsToJson(this);
}

@JsonEnum(valueField: 'packageManager')
enum SpurteJSPackageManager {
  npm('npm'),
  pnpm('pnpm'),
  yarn('yarn'),
  bun('bun');

  const SpurteJSPackageManager(this.packageManager);
  final String packageManager;
}

@JsonEnum(valueField: 'mode')
enum SpurteMode {
  development('development'),
  production('production');

  const SpurteMode(this.mode);
  final String mode;
}

@JsonEnum(valueField: 'logLevel')
enum SpurteLogLevel {
  debug('debug'),
  info('info'),
  warn('warn'),
  error('error'),
  none('none');

  const SpurteLogLevel(this.logLevel);
  final String logLevel;
}
