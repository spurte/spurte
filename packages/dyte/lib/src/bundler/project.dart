import 'dart:io';

import 'package:path/path.dart' as p;

String resolveEntry(String? entry, String dir) {
  if (entry != null) {
    return p.join(dir, entry);
  } else if (File(p.join(dir, 'web', 'main.dart')).existsSync()) {
    return p.join(dir, 'web', 'main.dart');
  } else if (File(p.join(dir, 'web', 'index.dart')).existsSync()) {
    return p.join(dir, 'web', 'index.dart');
  } else {
    throw Exception("Cannot find project entrypoint. Please sepcify a custom project entrypoint in your configuration file");
  }
}