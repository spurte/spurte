// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpurteConfig _$SpurteConfigFromJson(Map<String, dynamic> json) => SpurteConfig(
      base: json['base'] as String?,
      build: json['build'] == null
          ? null
          : SpurteDartBuildOptions.fromJson(
              json['build'] as Map<String, dynamic>),
      dev: json['dev'] == null
          ? null
          : SpurteDevOptions.fromJson(json['dev'] as Map<String, dynamic>),
      entry: json['entry'] as String?,
      experimental: json['experimental'] == null
          ? null
          : SpurteDartExperimentalOptions.fromJson(
              json['experimental'] as Map<String, dynamic>),
      hmr: json['hmr'] as bool?,
      js: json['js'] == null
          ? null
          : SpurteJsDartOptions.fromJson(json['js'] as Map<String, dynamic>),
      logLevel: $enumDecodeNullable(_$SpurteLogLevelEnumMap, json['logLevel']),
      mode: $enumDecodeNullable(_$SpurteModeEnumMap, json['mode']),
      plugins:
          (json['plugins'] as List<dynamic>?)?.map((e) => e as String).toList(),
      prod: json['prod'] == null
          ? null
          : SpurteProdOptions.fromJson(json['prod'] as Map<String, dynamic>),
      publicDir: json['publicDir'] as String?,
      publicRoot: json['publicRoot'] as String?,
      pubspec: json['pubspec'] as String?,
      root: json['root'] as String?,
      server: json['server'] == null
          ? null
          : SpurteServerOptions.fromJson(
              json['server'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpurteConfigToJson(SpurteConfig instance) =>
    <String, dynamic>{
      'base': instance.base,
      'build': instance.build,
      'dev': instance.dev,
      'entry': instance.entry,
      'experimental': instance.experimental,
      'hmr': instance.hmr,
      'js': instance.js,
      'logLevel': _$SpurteLogLevelEnumMap[instance.logLevel],
      'mode': _$SpurteModeEnumMap[instance.mode],
      'plugins': instance.plugins,
      'prod': instance.prod,
      'publicDir': instance.publicDir,
      'publicRoot': instance.publicRoot,
      'pubspec': instance.pubspec,
      'root': instance.root,
      'server': instance.server,
    };

const _$SpurteLogLevelEnumMap = {
  SpurteLogLevel.DEBUG: 'debug',
  SpurteLogLevel.ERROR: 'error',
  SpurteLogLevel.INFO: 'info',
  SpurteLogLevel.NONE: 'none',
  SpurteLogLevel.WARN: 'warn',
};

const _$SpurteModeEnumMap = {
  SpurteMode.DEVELOPMENT: 'development',
  SpurteMode.PRODUCTION: 'production',
};

SpurteDartBuildOptions _$SpurteDartBuildOptionsFromJson(
        Map<String, dynamic> json) =>
    SpurteDartBuildOptions(
      bundleAsJs: json['bundleAsJs'] as bool?,
      minify: json['minify'] as bool?,
      outdir: json['outdir'] as String?,
    );

Map<String, dynamic> _$SpurteDartBuildOptionsToJson(
        SpurteDartBuildOptions instance) =>
    <String, dynamic>{
      'bundleAsJs': instance.bundleAsJs,
      'minify': instance.minify,
      'outdir': instance.outdir,
    };

SpurteDevOptions _$SpurteDevOptionsFromJson(Map<String, dynamic> json) =>
    SpurteDevOptions(
      bundleJsDeps: json['bundleJSDeps'] as bool?,
      fullReload: json['fullReload'] as bool?,
    );

Map<String, dynamic> _$SpurteDevOptionsToJson(SpurteDevOptions instance) =>
    <String, dynamic>{
      'bundleJSDeps': instance.bundleJsDeps,
      'fullReload': instance.fullReload,
    };

SpurteDartExperimentalOptions _$SpurteDartExperimentalOptionsFromJson(
        Map<String, dynamic> json) =>
    SpurteDartExperimentalOptions(
      bundleWithTypes: json['bundleWithTypes'] as bool?,
      target:
          $enumDecodeNullable(_$SpurteDartBuildTargetEnumMap, json['target']),
      wasm: json['wasm'] == null
          ? null
          : SpurteDartWasmOptions.fromJson(
              json['wasm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpurteDartExperimentalOptionsToJson(
        SpurteDartExperimentalOptions instance) =>
    <String, dynamic>{
      'bundleWithTypes': instance.bundleWithTypes,
      'target': _$SpurteDartBuildTargetEnumMap[instance.target],
      'wasm': instance.wasm,
    };

const _$SpurteDartBuildTargetEnumMap = {
  SpurteDartBuildTarget.JS: 'js',
  SpurteDartBuildTarget.WASM: 'wasm',
};

SpurteDartWasmOptions _$SpurteDartWasmOptionsFromJson(
        Map<String, dynamic> json) =>
    SpurteDartWasmOptions(
      exportFile: json['exportFile'] as String?,
      importFile: json['importFile'] as String?,
    );

Map<String, dynamic> _$SpurteDartWasmOptionsToJson(
        SpurteDartWasmOptions instance) =>
    <String, dynamic>{
      'exportFile': instance.exportFile,
      'importFile': instance.importFile,
    };

SpurteJsDartOptions _$SpurteJsDartOptionsFromJson(Map<String, dynamic> json) =>
    SpurteJsDartOptions(
      cdn: json['cdn'] as String?,
      deno: json['deno'] as bool?,
      jsx: json['jsx'] as bool?,
      nodeModulesDir: json['nodeModulesDir'] as bool?,
      packageManager:
          $enumDecodeNullable(_$PackageManagerEnumMap, json['packageManager']),
      typescript: json['typescript'] as bool?,
    );

Map<String, dynamic> _$SpurteJsDartOptionsToJson(
        SpurteJsDartOptions instance) =>
    <String, dynamic>{
      'cdn': instance.cdn,
      'deno': instance.deno,
      'jsx': instance.jsx,
      'nodeModulesDir': instance.nodeModulesDir,
      'packageManager': _$PackageManagerEnumMap[instance.packageManager],
      'typescript': instance.typescript,
    };

const _$PackageManagerEnumMap = {
  PackageManager.BUN: 'bun',
  PackageManager.NPM: 'npm',
  PackageManager.PNPM: 'pnpm',
  PackageManager.YARN: 'yarn',
};

SpurteProdOptions _$SpurteProdOptionsFromJson(Map<String, dynamic> json) =>
    SpurteProdOptions(
      host: json['host'] as String?,
      https: json['https'] == null
          ? null
          : ProdHttps.fromJson(json['https'] as Map<String, dynamic>),
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpurteProdOptionsToJson(SpurteProdOptions instance) =>
    <String, dynamic>{
      'host': instance.host,
      'https': instance.https,
      'port': instance.port,
    };

ProdHttps _$ProdHttpsFromJson(Map<String, dynamic> json) => ProdHttps(
      cert: json['cert'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$ProdHttpsToJson(ProdHttps instance) => <String, dynamic>{
      'cert': instance.cert,
      'key': instance.key,
    };

SpurteServerOptions _$SpurteServerOptionsFromJson(Map<String, dynamic> json) =>
    SpurteServerOptions(
      host: json['host'] as String?,
      https: json['https'] == null
          ? null
          : ServerHttps.fromJson(json['https'] as Map<String, dynamic>),
      port: (json['port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpurteServerOptionsToJson(
        SpurteServerOptions instance) =>
    <String, dynamic>{
      'host': instance.host,
      'https': instance.https,
      'port': instance.port,
    };

ServerHttps _$ServerHttpsFromJson(Map<String, dynamic> json) => ServerHttps(
      cert: json['cert'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$ServerHttpsToJson(ServerHttps instance) =>
    <String, dynamic>{
      'cert': instance.cert,
      'key': instance.key,
    };
