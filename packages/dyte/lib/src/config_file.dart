import 'dart:io';
import 'package:path/path.dart' as p;

String getConfigFile(Directory dir, String name) {
  return ["$name.config.json", "$name.config.yaml"].map((e) => File(p.join(dir.path, e))).firstWhere((element) => element.existsSync()).path;
}