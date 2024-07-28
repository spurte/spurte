import '../dyte_config.dart';

/// Generates default Dyte Config in the case there is none anymore
DyteConfig defaultConfig(DyteMode mode, String cwd) {
  return DyteConfig(
    root: cwd,
    base: "/",
    mode: mode,
    publicDir: "public",
    server: DyteServerOptions(port: 8000, host: "localhost"),
    dev: DyteDevOptions(bundleJsDeps: true),
    build: DyteBuildOptions(outdir: "build"),
  );
}
