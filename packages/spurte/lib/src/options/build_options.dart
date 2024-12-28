class BuildOptions {
  final bool wasm;
  final bool minify;
  final String cwd;
  final String dist;

  /// Absolute path
  final String? importFile;

  /// Absolute path
  final String? exportFile;
  final List<String> entrypoints;

  final String index;
  final String publicDir;
  final String publicRoot;
  final bool verbose;

  const BuildOptions(
      {this.wasm = false,
      this.minify = true,
      required this.cwd,
      this.index = "index.html",
      this.dist = "dist",
      this.importFile,
      this.exportFile,
      this.entrypoints = const [],
      this.publicDir = 'public',
      this.publicRoot = '/',
      this.verbose = false});
}
