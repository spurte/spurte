class ServerOptions {
  int port;
  String host;
  String? cert;
  String? key;
  String publicDir;
  String publicRoot;
  String index;

  ServerOptions({
    required this.host,
    required this.port,
    this.publicDir = 'public',
    this.publicRoot = '/',
    this.index = 'index.html',
    this.cert, this.key
  });
}
