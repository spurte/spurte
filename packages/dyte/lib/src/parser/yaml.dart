import 'dart:io';

import 'package:dyte/src/config/dyte_config.dart';
import 'package:yaml/yaml.dart';

DyteConfig parseConfig(String path) {
  Map<String, dynamic> config;
  final yamlData = File(path).readAsStringSync();

   try {
    config = loadYaml(yamlData);
  } catch (e) {
    throw FormatException("JSON is meant to be a map", e);
  }

  try {
    return DyteConfig.fromJson(config);
  } catch (e) {
    throw Exception("Error parsing config file, $e");
  }
}