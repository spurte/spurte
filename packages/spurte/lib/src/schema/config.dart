// Copyright (C) 2024 Nikechukwu Okoronkwo
//
// This file, as well as all the code provided here is licensed under an MIT license 
// that can be found in the LICENSE file at the root of this project.

// This file contains configuration for the Spurte Configuration. For more information, see https://github.com/spurte/schema

// ignore_for_file: constant_identifier_names

// To parse this JSON data, do
//
//     final spurteConfig = spurteConfigFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'config.g.dart';

SpurteConfig spurteConfigFromJson(String str) => SpurteConfig.fromJson(json.decode(str));

String spurteConfigToJson(SpurteConfig data) => json.encode(data.toJson());


///The configuration options for the Spurte Dart implementation.
///
///This extends the common options, with implementation-specific options.
@JsonSerializable()
class SpurteConfig {
    
    ///The base url of the spurte project.
    @JsonKey(name: "base")
    final String? base;
    
    ///Options for customizing building the project
    @JsonKey(name: "build")
    final SpurteDartBuildOptions? build;
    
    ///Development options, used for customizing development as well as for other dev options.
    @JsonKey(name: "dev")
    final SpurteDevOptions? dev;
    
    ///The main entrypoint of the application
    @JsonKey(name: "entry")
    final String? entry;
    
    ///Experimental options for working with Spurte
    @JsonKey(name: "experimental")
    final SpurteDartExperimentalOptions? experimental;
    
    ///Whether hot module replacement is active on the given project
    ///
    ///Defaults to true
    @JsonKey(name: "hmr")
    final bool? hmr;
    
    ///Options used for configuring the use of JavaScript projects and dependencies in the
    ///Spurte Project
    @JsonKey(name: "js")
    final SpurteJsDartOptions? js;
    
    ///The logging level for the spurte server
    @JsonKey(name: "logLevel")
    final SpurteLogLevel? logLevel;
    
    ///Explicitly set the mode and overwrite the default mode or mode passed via the command
    ///line.
    @JsonKey(name: "mode")
    final SpurteMode? mode;
    
    ///The list of plugins provided for this project, either as a file path or as a package uri
    @JsonKey(name: "plugins")
    final List<String>? plugins;
    
    ///Configure the options for running the spurte production file server for serving the
    ///production build.
    @JsonKey(name: "prod")
    final SpurteProdOptions? prod;
    
    ///The public directory to use for serving public assets. Defaults to `public/`
    @JsonKey(name: "publicDir")
    final String? publicDir;
    
    ///The base url to serve public assets at. Defaults to `/`
    @JsonKey(name: "publicRoot")
    final String? publicRoot;
    
    ///The path to the pubspec file used for dart configuration. Defaults to the project root
    @JsonKey(name: "pubspec")
    final String? pubspec;
    
    ///The root of the spurte project. Defaults to the current working directory
    @JsonKey(name: "root")
    final String? root;
    
    ///Configure the server options for Spurte's development server
    @JsonKey(name: "server")
    final SpurteServerOptions? server;

    SpurteConfig({
        this.base,
        this.build,
        this.dev,
        this.entry,
        this.experimental,
        this.hmr,
        this.js,
        this.logLevel,
        this.mode,
        this.plugins,
        this.prod,
        this.publicDir,
        this.publicRoot,
        this.pubspec,
        this.root,
        this.server,
    });

    factory SpurteConfig.fromJson(Map<String, dynamic> json) => _$SpurteConfigFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteConfigToJson(this);
}


///Options for customizing building the project
@JsonSerializable()
class SpurteDartBuildOptions {
    
    ///Whether to bundle the project with JS
    ///
    ///Defaults to `true`
    @JsonKey(name: "bundleAsJs")
    final bool? bundleAsJs;
    
    ///Whether to minify output
    ///
    ///Defaults to `true`
    @JsonKey(name: "minify")
    final bool? minify;
    
    ///The output directory for the build files
    ///
    ///Defaults to the `dist/` directory
    @JsonKey(name: "outdir")
    final String? outdir;

    SpurteDartBuildOptions({
        this.bundleAsJs,
        this.minify,
        this.outdir,
    });

    factory SpurteDartBuildOptions.fromJson(Map<String, dynamic> json) => _$SpurteDartBuildOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteDartBuildOptionsToJson(this);
}


///Development options, used for customizing development as well as for other dev options.
@JsonSerializable()
class SpurteDevOptions {
    
    ///Whether to bundle external dependencies or import them as-is.
    ///
    ///Defaults to true, meaning url dependencies are bundled.
    @JsonKey(name: "bundleJSDeps")
    final bool? bundleJsDeps;
    
    ///Whether to initiate a full reload upon receiving changes
    ///
    ///Defaults to false
    @JsonKey(name: "fullReload")
    final bool? fullReload;

    SpurteDevOptions({
        this.bundleJsDeps,
        this.fullReload,
    });

    factory SpurteDevOptions.fromJson(Map<String, dynamic> json) => _$SpurteDevOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteDevOptionsToJson(this);
}


///Experimental options for working with Spurte
@JsonSerializable()
class SpurteDartExperimentalOptions {
    
    ///Whether to add types to the bundled JS files
    ///
    ///This option defaults to `false`, but if `bundleAsJs` is provided as `false`, this option
    ///is ignored.
    ///
    ///> **NOTE**: This option is experimental, and doesn't work at the moment
    @JsonKey(name: "bundleWithTypes")
    final bool? bundleWithTypes;
    
    ///The build target for the given project - "js" or "wasm"
    @JsonKey(name: "target")
    final SpurteDartBuildTarget? target;
    
    ///WASM options
    ///
    ///These options are only used when the build target at `experimental.target` is set to
    ///"wasm"
    ///
    ///As of currently, these options only apply to Dart builds.
    ///
    ///For more information on how to use wasm with dart, see https://dart.dev/web/wasm and
    ///https://chromium.googlesource.com/external/github.com/dart-lang/sdk/+/refs/tags/3.5.0-90.0.dev/pkg/dart2wasm/
    @JsonKey(name: "wasm")
    final SpurteDartWasmOptions? wasm;

    SpurteDartExperimentalOptions({
        this.bundleWithTypes,
        this.target,
        this.wasm,
    });

    factory SpurteDartExperimentalOptions.fromJson(Map<String, dynamic> json) => _$SpurteDartExperimentalOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteDartExperimentalOptionsToJson(this);
}


///The build target for the given project - "js" or "wasm"
enum SpurteDartBuildTarget {
    @JsonValue("js")
    JS,
    @JsonValue("wasm")
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
@JsonSerializable()
class SpurteDartWasmOptions {
    
    ///A file that can be used to make use of WASM exports, if any, from the module
    ///
    ///If no wasm exports are made, then this file is not included in the build
    @JsonKey(name: "exportFile")
    final String? exportFile;
    
    ///The file that includes the import object
    ///
    ///The import object here should be provided as a default export from the given file.
    ///Support for using dart to export such import object is not yet implemented
    @JsonKey(name: "importFile")
    final String? importFile;

    SpurteDartWasmOptions({
        this.exportFile,
        this.importFile,
    });

    factory SpurteDartWasmOptions.fromJson(Map<String, dynamic> json) => _$SpurteDartWasmOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteDartWasmOptionsToJson(this);
}


///Options used for configuring the use of JavaScript projects and dependencies in the
///Spurte Project
@JsonSerializable()
class SpurteJsDartOptions {
    
    ///The CDN to use to cache NPM dependencies during development.
    ///Defaults to undefined for Spurte's own NPM dependency management.
    ///
    ///if `nodeModulesDir` is true, this option is ignored
    @JsonKey(name: "cdn")
    final String? cdn;
    
    ///Whether deno is used in the given project
    ///
    ///If not defined, this can be inferred through the use of a `deno.json` file in the project
    @JsonKey(name: "deno")
    final bool? deno;
    
    ///Whether JSX is being used in this project
    @JsonKey(name: "jsx")
    final bool? jsx;
    
    ///Whether to make use of a `node_modules` directory
    @JsonKey(name: "nodeModulesDir")
    final bool? nodeModulesDir;
    
    ///The package manager used to install the node modules, if any.
    ///
    ///If implemented in JS, this defaults to undefined - meaning none will be used for
    ///installing dependencies, and Deno will be used to cache the npm dependencies
    ///Else this defaults to "npm"
    ///
    ///if `nodeModulesDir` is undefined or false, this option is ignored.
    @JsonKey(name: "packageManager")
    final PackageManager? packageManager;
    
    ///Whether typescript is being used in this project
    @JsonKey(name: "typescript")
    final bool? typescript;

    SpurteJsDartOptions({
        this.cdn,
        this.deno,
        this.jsx,
        this.nodeModulesDir,
        this.packageManager,
        this.typescript,
    });

    factory SpurteJsDartOptions.fromJson(Map<String, dynamic> json) => _$SpurteJsDartOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteJsDartOptionsToJson(this);
}


///The package manager used to install the node modules, if any.
///
///If implemented in JS, this defaults to undefined - meaning none will be used for
///installing dependencies, and Deno will be used to cache the npm dependencies
///Else this defaults to "npm"
///
///if `nodeModulesDir` is undefined or false, this option is ignored.
enum PackageManager {
    @JsonValue("bun")
    BUN,
    @JsonValue("npm")
    NPM,
    @JsonValue("pnpm")
    PNPM,
    @JsonValue("yarn")
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
    @JsonValue("debug")
    DEBUG,
    @JsonValue("error")
    ERROR,
    @JsonValue("info")
    INFO,
    @JsonValue("none")
    NONE,
    @JsonValue("warn")
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
    @JsonValue("development")
    DEVELOPMENT,
    @JsonValue("production")
    PRODUCTION
}

final spurteModeValues = EnumValues({
    "development": SpurteMode.DEVELOPMENT,
    "production": SpurteMode.PRODUCTION
});


///Configure the options for running the spurte production file server for serving the
///production build.
@JsonSerializable()
class SpurteProdOptions {
    
    ///The server hostname. Defaults to "localhost"
    @JsonKey(name: "host")
    final String? host;
    
    ///HTTPS information that, when provided, can be used for creating a https server
    @JsonKey(name: "https")
    final ProdHttps? https;
    
    ///The server port number. Defaults to 8000 for development, and 3000 for production preview
    @JsonKey(name: "port")
    final int? port;

    SpurteProdOptions({
        this.host,
        this.https,
        this.port,
    });

    factory SpurteProdOptions.fromJson(Map<String, dynamic> json) => _$SpurteProdOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteProdOptionsToJson(this);
}


///HTTPS information that, when provided, can be used for creating a https server
@JsonSerializable()
class ProdHttps {
    
    ///The path to the https certificate used for creating the https server
    @JsonKey(name: "cert")
    final String? cert;
    
    ///The path to the https key used for creating the https server
    @JsonKey(name: "key")
    final String? key;

    ProdHttps({
        this.cert,
        this.key,
    });

    factory ProdHttps.fromJson(Map<String, dynamic> json) => _$ProdHttpsFromJson(json);

    Map<String, dynamic> toJson() => _$ProdHttpsToJson(this);
}


///Configure the server options for Spurte's development server
@JsonSerializable()
class SpurteServerOptions {
    
    ///The server hostname. Defaults to "localhost"
    @JsonKey(name: "host")
    final String? host;
    
    ///HTTPS information that, when provided, can be used for creating a https server
    @JsonKey(name: "https")
    final ServerHttps? https;
    
    ///The server port number. Defaults to 8000 for development, and 3000 for production preview
    @JsonKey(name: "port")
    final int? port;

    SpurteServerOptions({
        this.host,
        this.https,
        this.port,
    });

    factory SpurteServerOptions.fromJson(Map<String, dynamic> json) => _$SpurteServerOptionsFromJson(json);

    Map<String, dynamic> toJson() => _$SpurteServerOptionsToJson(this);
}


///HTTPS information that, when provided, can be used for creating a https server
@JsonSerializable()
class ServerHttps {
    
    ///The path to the https certificate used for creating the https server
    @JsonKey(name: "cert")
    final String? cert;
    
    ///The path to the https key used for creating the https server
    @JsonKey(name: "key")
    final String? key;

    ServerHttps({
        this.cert,
        this.key,
    });

    factory ServerHttps.fromJson(Map<String, dynamic> json) => _$ServerHttpsFromJson(json);

    Map<String, dynamic> toJson() => _$ServerHttpsToJson(this);
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
