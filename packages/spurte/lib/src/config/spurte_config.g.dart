// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spurte_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpurteConfig _$SpurteConfigFromJson(Map<String, dynamic> json) => SpurteConfig(
      root: json['root'] as String?,
      base: json['base'] as String?,
      publicDir: json['publicDir'] as String?,
      publicRoot: json['publicRoot'] as String?,
      pubspec: json['pubspec'] as String?,
      dev: json['dev'] == null
          ? null
          : SpurteDevOptions.fromJson(json['dev'] as Map<String, dynamic>),
      build: json['build'] == null
          ? null
          : SpurteBuildOptions.fromJson(json['build'] as Map<String, dynamic>),
      server: json['server'] == null
          ? null
          : SpurteServerOptions.fromJson(json['server'] as Map<String, dynamic>),
      plugins: (json['plugins'] as List<dynamic>?)?.map((e) => e as String),
      js: json['js'] == null
          ? null
          : SpurteJSOptions.fromJson(json['js'] as Map<String, dynamic>),
      mode: $enumDecodeNullable(_$SpurteModeEnumMap, json['mode']),
      logLevel: $enumDecodeNullable(_$SpurteLogLevelEnumMap, json['logLevel']),
      experimental: json['experimental'] == null
          ? null
          : SpurteExperimentalOptions.fromJson(
              json['experimental'] as Map<String, dynamic>),
      multiPackages: json['multiPackages'] as bool?,
      hmr: json['hmr'] as bool?,
      entry: json['entry'] as String?,
    );

Map<String, dynamic> _$SpurteConfigToJson(SpurteConfig instance) =>
    <String, dynamic>{
      'root': instance.root,
      'base': instance.base,
      'publicDir': instance.publicDir,
      'publicRoot': instance.publicRoot,
      'entry': instance.entry,
      'mode': _$SpurteModeEnumMap[instance.mode],
      'plugins': instance.plugins?.toList(),
      'pubspec': instance.pubspec,
      'dev': instance.dev,
      'build': instance.build,
      'server': instance.server,
      'logLevel': _$SpurteLogLevelEnumMap[instance.logLevel],
      'hmr': instance.hmr,
      'js': instance.js,
      'experimental': instance.experimental,
      'multiPackages': instance.multiPackages,
    };

const _$SpurteModeEnumMap = {
  SpurteMode.development: 'development',
  SpurteMode.production: 'production',
};

const _$SpurteLogLevelEnumMap = {
  SpurteLogLevel.debug: 'debug',
  SpurteLogLevel.info: 'info',
  SpurteLogLevel.warn: 'warn',
  SpurteLogLevel.error: 'error',
  SpurteLogLevel.none: 'none',
};

SpurteServerOptions _$SpurteServerOptionsFromJson(Map<String, dynamic> json) =>
    SpurteServerOptions(
      port: (json['port'] as num?)?.toInt(),
      host: json['host'] as String?,
      https: json['https'] == null
          ? null
          : SpurteServerHttpsOptions.fromJson(
              json['https'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpurteServerOptionsToJson(SpurteServerOptions instance) =>
    <String, dynamic>{
      'port': instance.port,
      'host': instance.host,
      'https': instance.https,
    };

SpurteServerHttpsOptions _$SpurteServerHttpsOptionsFromJson(
        Map<String, dynamic> json) =>
    SpurteServerHttpsOptions(
      cert: json['cert'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$SpurteServerHttpsOptionsToJson(
        SpurteServerHttpsOptions instance) =>
    <String, dynamic>{
      'cert': instance.cert,
      'key': instance.key,
    };

SpurteDevOptions _$SpurteDevOptionsFromJson(Map<String, dynamic> json) =>
    SpurteDevOptions(
      bundleJsDeps: json['bundleJsDeps'] as bool?,
      fullReload: json['fullReload'] as bool?,
    );

Map<String, dynamic> _$SpurteDevOptionsToJson(SpurteDevOptions instance) =>
    <String, dynamic>{
      'bundleJsDeps': instance.bundleJsDeps,
      'fullReload': instance.fullReload,
    };

SpurteBuildOptions _$SpurteBuildOptionsFromJson(Map<String, dynamic> json) =>
    SpurteBuildOptions(
      outdir: json['outdir'] as String?,
      bundleAsJs: json['bundleAsJs'] as bool?,
      minify: json['minify'] as bool?,
    );

Map<String, dynamic> _$SpurteBuildOptionsToJson(SpurteBuildOptions instance) =>
    <String, dynamic>{
      'outdir': instance.outdir,
      'bundleAsJs': instance.bundleAsJs,
      'minify': instance.minify,
    };

SpurteJSOptions _$SpurteJSOptionsFromJson(Map<String, dynamic> json) =>
    SpurteJSOptions(
      typescript: json['typescript'] as bool?,
      jsx: json['jsx'] as bool?,
      nodeModulesDir: json['nodeModulesDir'] as bool?,
      packageManager: $enumDecodeNullable(
          _$SpurteJSPackageManagerEnumMap, json['packageManager']),
      cdn: json['cdn'] as String?,
      deno: json['deno'] as bool?,
    );

Map<String, dynamic> _$SpurteJSOptionsToJson(SpurteJSOptions instance) =>
    <String, dynamic>{
      'typescript': instance.typescript,
      'jsx': instance.jsx,
      'nodeModulesDir': instance.nodeModulesDir,
      'packageManager': _$SpurteJSPackageManagerEnumMap[instance.packageManager],
      'cdn': instance.cdn,
      'deno': instance.deno,
    };

const _$SpurteJSPackageManagerEnumMap = {
  SpurteJSPackageManager.npm: 'npm',
  SpurteJSPackageManager.pnpm: 'pnpm',
  SpurteJSPackageManager.yarn: 'yarn',
  SpurteJSPackageManager.bun: 'bun',
};
