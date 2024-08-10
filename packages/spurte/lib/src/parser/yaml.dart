import 'dart:io';

import 'package:yaml/yaml.dart';

import '../config/config.dart';

SpurteConfig parseConfig(String path) {
  Map<String, dynamic> config;
  final yamlData = File(path).readAsStringSync();

   try {
    config = loadYaml(yamlData);
  } catch (e) {
    throw FormatException("JSON is meant to be a map", e);
  }

  try {
    return SpurteConfig.fromJson(config);
  } catch (e) {
    throw Exception("Error parsing config file, $e");
  }
}