import 'dart:convert';
import 'dart:io';

Map parseConfig(String path) {
  Map config;
  final jsonData = File(path).readAsStringSync();

  try {
    config = jsonDecode(jsonData);
  } catch (e) {
    throw FormatException("JSON is meant to be a map", e);
  }
}
