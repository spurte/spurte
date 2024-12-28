import 'dart:io';
import 'config/config.dart';
import 'config/parser/parser.dart';
import 'package:path/path.dart' as p;

String getConfigFile(Directory dir, String name) {
  return ["$name.config.json", "$name.config.yaml"]
      .map((e) => File(p.join(dir.path, e)))
      .firstWhere((element) => element.existsSync())
      .path;
}

SpurteConfig getConfiguration(Directory dir,
    {required String name, String? config}) {
  String file = getConfigFile(dir, name);

  return parseConfig(file);
}
