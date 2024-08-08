import 'dart:io';

import '../api/plugin.dart';

resolve(DytePlugin plugin, String dir) async {
  final directory = Directory(dir);
  await for (final fse in directory.list(recursive: true)) {
    if (fse is! File) {

    }
  }
}