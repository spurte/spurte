import '../spurte_config.dart';

/// Generates default Spurte Config in the case there is none anymore
SpurteConfig defaultConfig(SpurteMode mode, String cwd) {
  return SpurteConfig(
    root: cwd,
    base: "/",
    mode: mode,
    publicDir: "public",
    server: SpurteServerOptions(port: 8000, host: "localhost"),
    dev: SpurteDevOptions(bundleJsDeps: true),
    build: SpurteBuildOptions(outdir: "build"),
  );
}
