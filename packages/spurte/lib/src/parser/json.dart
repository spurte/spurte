import 'dart:convert';
import 'dart:io';

import '../config/spurte_config.dart';

SpurteConfig parseConfig(String path) {
  Map<String, dynamic> config;
  final jsonData = File(path).readAsStringSync();

  try {
    config = jsonDecode(jsonData);
  } catch (e) {
    throw FormatException("JSON is meant to be a map", e);
  }

  try {
    return SpurteConfig.fromJson(config);
  } catch (e) {
    throw Exception("Error parsing config file, $e");
  }
}
