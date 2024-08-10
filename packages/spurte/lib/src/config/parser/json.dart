import 'dart:io';

import '../config.dart';

SpurteConfig parseConfig(String path) {
  try {
    return spurteConfigFromJson(File(path).readAsStringSync());
  } catch (err) {
    rethrow;
  }
}
