
class ServerOptions {
  final int port;
  final String host;
  final String? cert;
  final String? key;
  final String publicDir;
  final String publicRoot;
  final String index;
  final String cwd;
  final String entry;
  final bool prodServer;

  const ServerOptions({
    required this.host,
    required this.port,
    required this.cwd,
    required this.entry,
    this.publicDir = 'public',
    this.publicRoot = '/',
    this.index = 'index.html',
    this.cert, this.key,
    this.prodServer = false
  });
}
