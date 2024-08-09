import '../serve/project.dart';
import 'package:spurte/src/config/spurte_config.dart';
import 'package:path/path.dart';

import 'server_options.dart';

export 'server_options.dart';

ServerOptions createServerOptions(SpurteConfig config, String cwd) {
  return ServerOptions(
    entry: resolveEntry(config.entry, cwd),
    host: config.server?.host ?? "localhost", 
    port: config.server?.port ?? 8000,
    cert: config.server?.https?.cert,
    key: config.server?.https?.key,
    publicDir: config.publicDir ?? 'public',
    publicRoot: config.publicRoot ?? '/',
    index: join(config.root ?? cwd, 'index.html'),
    cwd: config.root ?? cwd,
  );
}