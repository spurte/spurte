library dyte.config;

import 'dyte_config.dart';

export 'dyte_config.dart';

/// Public function used for defining configuration in a `dyte.config.dart` file.
///
/// The configuration is passed as, and returned as a [DyteConfig] object.
///
/// This function contains all the options used for the configuration.
/// Configuration files should be written with a variable assignment to this function. The variable should be called `config`, and should look something like this:
///
/// ```dart
/// import 'package:dyte/dyte.dart';
///
/// // Dyte Configuration in a dyte.config.dart file
/// var config = defineConfig(
/// 	// define configuration here
/// );
/// ```
DyteConfig defineConfig({
  String? base,
  DyteMode? mode,
  DyteLogLevel? logLevel,
  DyteExperimentalOptions? experimental,
  bool? multiPackages,
  bool? hmr,
  DyteJSOptions? js,
  String? publicDir,
  DyteServerOptions? server,
  DyteDevOptions? dev,
  DyteBuildOptions? build,
  String? pubspec,
  List<DytePlugin>? plugins,
  String? publicRoot,
  String? root,
}) {
  return DyteConfig(
    base: base,
    mode: mode,
    publicDir: publicDir,
    server: server,
    dev: dev,
    build: build,
    js: js,
    pubspec: pubspec,
    plugins: plugins,
    logLevel: logLevel,
    experimental: experimental,
    multiPackages: multiPackages,
    hmr: hmr,
    publicRoot: publicRoot,
    root: root,
  );
}

/// Function used for merging configuration together.
///
/// While merging the [superior] configuration is given more priority over the [inferior],
/// meaning that the value of [superior] is used first before the value of [inferior].
///
/// See [defineConfig] for more information about the options, and how the configuration works.
DyteConfig mergeConfig(DyteConfig superior, DyteConfig inferior) {
  return DyteConfig(
    base: superior.base ?? inferior.base,
    mode: superior.mode ?? inferior.mode,
    publicDir: superior.publicDir ?? inferior.publicDir,
    server: superior.server ?? inferior.server,
    dev: superior.dev ?? inferior.dev,
    build: superior.build ?? inferior.build,
    js: superior.js ?? inferior.js,
    pubspec: superior.pubspec ?? inferior.pubspec,
    plugins: superior.plugins ?? inferior.plugins,
    logLevel: superior.logLevel ?? inferior.logLevel,
    experimental: superior.experimental ?? inferior.experimental,
    multiPackages: superior.multiPackages ?? inferior.multiPackages,
    hmr: superior.hmr ?? inferior.hmr,
    publicRoot: superior.publicRoot ?? inferior.publicRoot,
    root: superior.root ?? inferior.root,
  );
}
