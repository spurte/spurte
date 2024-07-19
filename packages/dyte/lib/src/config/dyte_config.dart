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
class DyteConfig {
  final String? root;
  final String? base;
  final String? publicDir;
  final String? publicRoot;
  final String? pubspec;
  final DyteDevOptions? dev;
  final DyteBuildOptions? build;
  final DyteServerOptions? server;
  final Iterable<DytePlugin>? plugins;
  final DyteJSOptions? js;
  final DyteMode? mode;
  final DyteLogLevel? logLevel;
  final DyteExperimentalOptions? experimental;
  final bool? multiPackages;
  final bool? hmr;

  DyteConfig({ this.root,  this.base,  this.publicDir,  this.publicRoot,  this.pubspec,  this.dev,  this.build,  this.server,  this.plugins,  this.js,  this.mode,  this.logLevel,  this.experimental,  this.multiPackages,  this.hmr});

  // Dartpack Options

  // WAIGen Options
}

class DyteExperimentalOptions {
}

class DyteServerOptions {
  final int? port;
  final String? host;

  DyteServerOptions({ this.port,  this.host});
}

// TODO: Implement Plugin API
class DytePlugin {
}

class DyteDevOptions {
  final bool? bundleJsDeps;
  final bool? fullReload;

  DyteDevOptions({ this.bundleJsDeps,  this.fullReload});
}

class DyteBuildOptions {
  final String? outdir;
  final bool? bundleAsJs;
  final bool? bundleWithTypes;

  DyteBuildOptions({ this.outdir,  this.bundleAsJs,  this.bundleWithTypes});
}

class DyteJSOptions {
  final bool? typescript;
  final bool? jsx;

  final bool? nodeModulesDir;
  final DyteJSPackageManager? packageManager;
  final String? cdn;
  final bool? deno;

  DyteJSOptions({ this.typescript,  this.jsx,  this.nodeModulesDir,  this.packageManager,  this.cdn,  this.deno});

  // JSIGen Options
}

enum DyteJSPackageManager {
  npm,
  pnpm,
  yarn,
  bun
}

enum DyteMode {
  development,
  production
}

enum DyteLogLevel {
  debug,
  info,
  warn,
  error,
  none
}
