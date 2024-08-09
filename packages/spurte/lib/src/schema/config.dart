// Copyright (C) 2024 Nikechukwu Okoronkwo
//
// This file, as well as all the code provided here is licensed under an MIT license 
// that can be found in the LICENSE file at the root of this project.

// This file contains configuration for the Spurte Configuration. For more information, see https://github.com/spurte/schema

// ignore_for_file: constant_identifier_names

// To parse this JSON data, do
//
//     final spurteConfig = spurteConfigFromJson(jsonString);

import 'dart:convert';

SpurteConfig spurteConfigFromJson(String str) => SpurteConfig.fromJson(json.decode(str));

String spurteConfigToJson(SpurteConfig data) => json.encode(data.toJson());


///The configuration options for the Spurte Dart implementation.
///
///This extends the common options, with implementation-specific options.
class SpurteConfig {
    
    ///The base url of the spurte project.
    String? base;
    
    ///Options for customizing building the project
    SpurteDartBuildOptions? build;
    
    ///Development options, used for customizing development as well as for other dev options.
    SpurteDevOptions? dev;
    
    ///The main entrypoint of the application
    String? entry;
    
    ///Experimental options for working with Spurte
    SpurteDartExperimentalOptions experimental;
    
    ///Whether hot module replacement is active on the given project
    ///
    ///Defaults to true
    bool? hmr;
    
    ///Options used for configuring the use of JavaScript projects and dependencies in the
    ///Spurte Project
    SpurteJsDartOptions? js;
    
    ///The logging level for the spurte server
    SpurteLogLevel? logLevel;
    
    ///Explicitly set the mode and overwrite the default mode or mode passed via the command
    ///line.
    SpurteMode? mode;
    
    ///The list of plugins provided for this project, either as a file path or as a package uri
    List<String>? plugins;
    
    ///The public directory to use for serving public assets. Defaults to `public/`
    String? publicDir;
    
    ///The base url to serve public assets at. Defaults to `/`
    String? publicRoot;
    
    ///The path to the pubspec file used for dart configuration. Defaults to the project root
    String? pubspec;
    
    ///The root of the spurte project. Defaults to the current working directory
    String? root;
    
    ///Configure the server options for Spurte's development server
    SpurteServerOptions? server;

    SpurteConfig({
        this.base,
        this.build,
        this.dev,
        this.entry,
        required this.experimental,
        this.hmr,
        this.js,
        this.logLevel,
        this.mode,
        this.plugins,
        this.publicDir,
        this.publicRoot,
        this.pubspec,
        this.root,
        this.server,
    });

    factory SpurteConfig.fromJson(Map<String, dynamic> json) => SpurteConfig(
        base: json["base"],
        build: json["build"] == null ? null : SpurteDartBuildOptions.fromJson(json["build"]),
        dev: json["dev"] == null ? null : SpurteDevOptions.fromJson(json["dev"]),
        entry: json["entry"],
        experimental: SpurteDartExperimentalOptions.fromJson(json["experimental"]),
        hmr: json["hmr"],
        js: json["js"] == null ? null : SpurteJsDartOptions.fromJson(json["js"]),
        logLevel: spurteLogLevelValues.map[json["logLevel"]]!,
        mode: spurteModeValues.map[json["mode"]]!,
        plugins: json["plugins"] == null ? [] : List<String>.from(json["plugins"]!.map((x) => x)),
        publicDir: json["publicDir"],
        publicRoot: json["publicRoot"],
        pubspec: json["pubspec"],
        root: json["root"],
        server: json["server"] == null ? null : SpurteServerOptions.fromJson(json["server"]),
    );

    Map<String, dynamic> toJson() => {
        "base": base,
        "build": build?.toJson(),
        "dev": dev?.toJson(),
        "entry": entry,
        "experimental": experimental.toJson(),
        "hmr": hmr,
        "js": js?.toJson(),
        "logLevel": spurteLogLevelValues.reverse[logLevel],
        "mode": spurteModeValues.reverse[mode],
        "plugins": plugins == null ? [] : List<dynamic>.from(plugins!.map((x) => x)),
        "publicDir": publicDir,
        "publicRoot": publicRoot,
        "pubspec": pubspec,
        "root": root,
        "server": server?.toJson(),
    };
}


///Options for customizing building the project
class SpurteDartBuildOptions {
    
    ///Whether to bundle the project with JS
    ///
    ///Defaults to `true`
    bool? bundleAsJs;
    
    ///Whether to minify output
    ///
    ///Defaults to `true`
    bool? minify;
    
    ///The output directory for the build files
    ///
    ///Defaults to the `dist/` directory
    String? outdir;

    SpurteDartBuildOptions({
        this.bundleAsJs,
        this.minify,
        this.outdir,
    });

    factory SpurteDartBuildOptions.fromJson(Map<String, dynamic> json) => SpurteDartBuildOptions(
        bundleAsJs: json["bundleAsJs"],
        minify: json["minify"],
        outdir: json["outdir"],
    );

    Map<String, dynamic> toJson() => {
        "bundleAsJs": bundleAsJs,
        "minify": minify,
        "outdir": outdir,
    };
}


///Development options, used for customizing development as well as for other dev options.
class SpurteDevOptions {
    
    ///Whether to bundle external dependencies or import them as-is.
    ///
    ///Defaults to true, meaning url dependencies are bundled.
    bool? bundleJsDeps;
    
    ///Whether to initiate a full reload upon receiving changes
    ///
    ///Defaults to false
    bool? fullReload;

    SpurteDevOptions({
        this.bundleJsDeps,
        this.fullReload,
    });

    factory SpurteDevOptions.fromJson(Map<String, dynamic> json) => SpurteDevOptions(
        bundleJsDeps: json["bundleJSDeps"],
        fullReload: json["fullReload"],
    );

    Map<String, dynamic> toJson() => {
        "bundleJSDeps": bundleJsDeps,
        "fullReload": fullReload,
    };
}


///Experimental options for working with Spurte
class SpurteDartExperimentalOptions {
    
    ///Whether to add types to the bundled JS files
    ///
    ///This option defaults to `false`, but if `bundleAsJs` is provided as `false`, this option
    ///is ignored.
    ///
    ///> **NOTE**: This option is experimental, and doesn't work at the moment
    bool? bundleWithTypes;
    
    ///The build target for the given project - "js" or "wasm"
    SpurteDartBuildTarget? target;
    
    ///WASM options
    ///
    ///These options are only used when the build target at `experimental.target` is set to
    ///"wasm"
    ///
    ///As of currently, these options only apply to Dart builds.
    ///
    ///For more information on how to use wasm with dart, see https://dart.dev/web/wasm and
    ///https://chromium.googlesource.com/external/github.com/dart-lang/sdk/+/refs/tags/3.5.0-90.0.dev/pkg/dart2wasm/
    SpurteDartWasmOptions? wasm;

    SpurteDartExperimentalOptions({
        this.bundleWithTypes,
        this.target,
        this.wasm,
    });

    factory SpurteDartExperimentalOptions.fromJson(Map<String, dynamic> json) => SpurteDartExperimentalOptions(
        bundleWithTypes: json["bundleWithTypes"],
        target: spurteDartBuildTargetValues.map[json["target"]]!,
        wasm: json["wasm"] == null ? null : SpurteDartWasmOptions.fromJson(json["wasm"]),
    );

    Map<String, dynamic> toJson() => {
        "bundleWithTypes": bundleWithTypes,
        "target": spurteDartBuildTargetValues.reverse[target],
        "wasm": wasm?.toJson(),
    };
}


///The build target for the given project - "js" or "wasm"
enum SpurteDartBuildTarget {
    JS,
    WASM
}

final spurteDartBuildTargetValues = EnumValues({
    "js": SpurteDartBuildTarget.JS,
    "wasm": SpurteDartBuildTarget.WASM
});


///WASM options
///
///These options are only used when the build target at `experimental.target` is set to
///"wasm"
///
///As of currently, these options only apply to Dart builds.
///
///For more information on how to use wasm with dart, see https://dart.dev/web/wasm and
///https://chromium.googlesource.com/external/github.com/dart-lang/sdk/+/refs/tags/3.5.0-90.0.dev/pkg/dart2wasm/
class SpurteDartWasmOptions {
    
    ///A file that can be used to make use of WASM exports, if any, from the module
    ///
    ///If no wasm exports are made, then this file is not included in the build
    String? exportFile;
    
    ///The file that includes the import object
    ///
    ///The import object here should be provided as a default export from the given file.
    ///Support for using dart to export such import object is not yet implemented
    String? importFile;

    SpurteDartWasmOptions({
        this.exportFile,
        this.importFile,
    });

    factory SpurteDartWasmOptions.fromJson(Map<String, dynamic> json) => SpurteDartWasmOptions(
        exportFile: json["exportFile"],
        importFile: json["importFile"],
    );

    Map<String, dynamic> toJson() => {
        "exportFile": exportFile,
        "importFile": importFile,
    };
}


///Options used for configuring the use of JavaScript projects and dependencies in the
///Spurte Project
class SpurteJsDartOptions {
    
    ///The CDN to use to cache NPM dependencies during development.
    ///Defaults to undefined for Spurte's own NPM dependency management.
    ///
    ///if `nodeModulesDir` is true, this option is ignored
    String? cdn;
    
    ///Whether deno is used in the given project
    ///
    ///If not defined, this can be inferred through the use of a `deno.json` file in the project
    bool? deno;
    
    ///Whether JSX is being used in this project
    bool? jsx;
    
    ///Whether to make use of a `node_modules` directory
    bool? nodeModulesDir;
    
    ///The package manager used to install the node modules, if any.
    ///
    ///If implemented in JS, this defaults to undefined - meaning none will be used for
    ///installing dependencies, and Deno will be used to cache the npm dependencies
    ///Else this defaults to "npm"
    ///
    ///if `nodeModulesDir` is undefined or false, this option is ignored.
    PackageManager? packageManager;
    
    ///Whether typescript is being used in this project
    bool? typescript;

    SpurteJsDartOptions({
        this.cdn,
        this.deno,
        this.jsx,
        this.nodeModulesDir,
        this.packageManager,
        this.typescript,
    });

    factory SpurteJsDartOptions.fromJson(Map<String, dynamic> json) => SpurteJsDartOptions(
        cdn: json["cdn"],
        deno: json["deno"],
        jsx: json["jsx"],
        nodeModulesDir: json["nodeModulesDir"],
        packageManager: packageManagerValues.map[json["packageManager"]]!,
        typescript: json["typescript"],
    );

    Map<String, dynamic> toJson() => {
        "cdn": cdn,
        "deno": deno,
        "jsx": jsx,
        "nodeModulesDir": nodeModulesDir,
        "packageManager": packageManagerValues.reverse[packageManager],
        "typescript": typescript,
    };
}


///The package manager used to install the node modules, if any.
///
///If implemented in JS, this defaults to undefined - meaning none will be used for
///installing dependencies, and Deno will be used to cache the npm dependencies
///Else this defaults to "npm"
///
///if `nodeModulesDir` is undefined or false, this option is ignored.
enum PackageManager {
    BUN,
    NPM,
    PNPM,
    YARN
}

final packageManagerValues = EnumValues({
    "bun": PackageManager.BUN,
    "npm": PackageManager.NPM,
    "pnpm": PackageManager.PNPM,
    "yarn": PackageManager.YARN
});


///The logging level for the spurte server
enum SpurteLogLevel {
    DEBUG,
    ERROR,
    INFO,
    NONE,
    WARN
}

final spurteLogLevelValues = EnumValues({
    "debug": SpurteLogLevel.DEBUG,
    "error": SpurteLogLevel.ERROR,
    "info": SpurteLogLevel.INFO,
    "none": SpurteLogLevel.NONE,
    "warn": SpurteLogLevel.WARN
});


///Explicitly set the mode and overwrite the default mode or mode passed via the command
///line.
enum SpurteMode {
    DEVELOPMENT,
    PRODUCTION
}

final spurteModeValues = EnumValues({
    "development": SpurteMode.DEVELOPMENT,
    "production": SpurteMode.PRODUCTION
});


///Configure the server options for Spurte's development server
class SpurteServerOptions {
    
    ///The server hostname. Defaults to "localhost"
    String? host;
    
    ///HTTPS information that, when provided, can be used for creating a https server
    SpurteServerHttpsOptions? https;
    
    ///The server port number. Defaults to 8000
    int? port;

    SpurteServerOptions({
        this.host,
        this.https,
        this.port,
    });

    factory SpurteServerOptions.fromJson(Map<String, dynamic> json) => SpurteServerOptions(
        host: json["host"],
        https: json["https"] == null ? null : SpurteServerHttpsOptions.fromJson(json["https"]),
        port: json["port"],
    );

    Map<String, dynamic> toJson() => {
        "host": host,
        "https": https?.toJson(),
        "port": port,
    };
}


///HTTPS information that, when provided, can be used for creating a https server
class SpurteServerHttpsOptions {
    
    ///The path to the https certificate used for creating the https server
    String? cert;
    
    ///The path to the https key used for creating the https server
    String? key;

    SpurteServerHttpsOptions({
        this.cert,
        this.key,
    });

    factory SpurteServerHttpsOptions.fromJson(Map<String, dynamic> json) => SpurteServerHttpsOptions(
        cert: json["cert"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "cert": cert,
        "key": key,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
