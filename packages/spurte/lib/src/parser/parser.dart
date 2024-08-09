
import 'package:path/path.dart' as p;

import '../config/spurte_config.dart';

import 'json.dart' as json;
import 'yaml.dart' as yaml;

SpurteConfig parseConfig(String path) {
  switch (p.extension(path)) {
    case '.json':
      return json.parseConfig(path);
    case '.yaml':
      return yaml.parseConfig(path);
    default:
      throw Error();
  }
}