// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dyte_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DyteConfig _$DyteConfigFromJson(Map<String, dynamic> json) => DyteConfig(
      root: json['root'] as String?,
      base: json['base'] as String?,
      publicDir: json['publicDir'] as String?,
      publicRoot: json['publicRoot'] as String?,
      pubspec: json['pubspec'] as String?,
      dev: json['dev'] == null
          ? null
          : DyteDevOptions.fromJson(json['dev'] as Map<String, dynamic>),
      build: json['build'] == null
          ? null
          : DyteBuildOptions.fromJson(json['build'] as Map<String, dynamic>),
      server: json['server'] == null
          ? null
          : DyteServerOptions.fromJson(json['server'] as Map<String, dynamic>),
      plugins: (json['plugins'] as List<dynamic>?)?.map((e) => e as String),
      js: json['js'] == null
          ? null
          : DyteJSOptions.fromJson(json['js'] as Map<String, dynamic>),
      mode: $enumDecodeNullable(_$DyteModeEnumMap, json['mode']),
      logLevel: $enumDecodeNullable(_$DyteLogLevelEnumMap, json['logLevel']),
      experimental: json['experimental'] == null
          ? null
          : DyteExperimentalOptions.fromJson(
              json['experimental'] as Map<String, dynamic>),
      multiPackages: json['multiPackages'] as bool?,
      hmr: json['hmr'] as bool?,
    );

Map<String, dynamic> _$DyteConfigToJson(DyteConfig instance) =>
    <String, dynamic>{
      'root': instance.root,
      'base': instance.base,
      'publicDir': instance.publicDir,
      'publicRoot': instance.publicRoot,
      'pubspec': instance.pubspec,
      'dev': instance.dev,
      'build': instance.build,
      'server': instance.server,
      'plugins': instance.plugins?.toList(),
      'js': instance.js,
      'mode': _$DyteModeEnumMap[instance.mode],
      'logLevel': _$DyteLogLevelEnumMap[instance.logLevel],
      'experimental': instance.experimental,
      'multiPackages': instance.multiPackages,
      'hmr': instance.hmr,
    };

const _$DyteModeEnumMap = {
  DyteMode.development: 'development',
  DyteMode.production: 'production',
};

const _$DyteLogLevelEnumMap = {
  DyteLogLevel.debug: 'debug',
  DyteLogLevel.info: 'info',
  DyteLogLevel.warn: 'warn',
  DyteLogLevel.error: 'error',
  DyteLogLevel.none: 'none',
};

DyteServerOptions _$DyteServerOptionsFromJson(Map<String, dynamic> json) =>
    DyteServerOptions(
      port: (json['port'] as num?)?.toInt(),
      host: json['host'] as String?,
      https: json['https'] == null
          ? null
          : DyteServerHttpsOptions.fromJson(
              json['https'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DyteServerOptionsToJson(DyteServerOptions instance) =>
    <String, dynamic>{
      'port': instance.port,
      'host': instance.host,
      'https': instance.https,
    };

DyteServerHttpsOptions _$DyteServerHttpsOptionsFromJson(
        Map<String, dynamic> json) =>
    DyteServerHttpsOptions(
      cert: json['cert'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$DyteServerHttpsOptionsToJson(
        DyteServerHttpsOptions instance) =>
    <String, dynamic>{
      'cert': instance.cert,
      'key': instance.key,
    };

DyteDevOptions _$DyteDevOptionsFromJson(Map<String, dynamic> json) =>
    DyteDevOptions(
      bundleJsDeps: json['bundleJsDeps'] as bool?,
      fullReload: json['fullReload'] as bool?,
    );

Map<String, dynamic> _$DyteDevOptionsToJson(DyteDevOptions instance) =>
    <String, dynamic>{
      'bundleJsDeps': instance.bundleJsDeps,
      'fullReload': instance.fullReload,
    };

DyteBuildOptions _$DyteBuildOptionsFromJson(Map<String, dynamic> json) =>
    DyteBuildOptions(
      outdir: json['outdir'] as String?,
      bundleAsJs: json['bundleAsJs'] as bool?,
      bundleWithTypes: json['bundleWithTypes'] as bool?,
    );

Map<String, dynamic> _$DyteBuildOptionsToJson(DyteBuildOptions instance) =>
    <String, dynamic>{
      'outdir': instance.outdir,
      'bundleAsJs': instance.bundleAsJs,
      'bundleWithTypes': instance.bundleWithTypes,
    };

DyteJSOptions _$DyteJSOptionsFromJson(Map<String, dynamic> json) =>
    DyteJSOptions(
      typescript: json['typescript'] as bool?,
      jsx: json['jsx'] as bool?,
      nodeModulesDir: json['nodeModulesDir'] as bool?,
      packageManager: $enumDecodeNullable(
          _$DyteJSPackageManagerEnumMap, json['packageManager']),
      cdn: json['cdn'] as String?,
      deno: json['deno'] as bool?,
    );

Map<String, dynamic> _$DyteJSOptionsToJson(DyteJSOptions instance) =>
    <String, dynamic>{
      'typescript': instance.typescript,
      'jsx': instance.jsx,
      'nodeModulesDir': instance.nodeModulesDir,
      'packageManager': _$DyteJSPackageManagerEnumMap[instance.packageManager],
      'cdn': instance.cdn,
      'deno': instance.deno,
    };

const _$DyteJSPackageManagerEnumMap = {
  DyteJSPackageManager.npm: 'npm',
  DyteJSPackageManager.pnpm: 'pnpm',
  DyteJSPackageManager.yarn: 'yarn',
  DyteJSPackageManager.bun: 'bun',
};
