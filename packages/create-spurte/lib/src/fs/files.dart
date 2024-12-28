import 'dart:collection';
import 'dart:io';
import 'package:path/path.dart' as p;

abstract class VFileSystemEntity {
  String get name;
  set name(String newName);

  void create([String? path]);
}

class VFile extends VFileSystemEntity {
  @override
  String name;

  String contents;

  VFile(this.name, {this.contents = ''});

  @override
  void create([String? path]) {
    File(p.join(path ?? '.', name)).writeAsStringSync(contents);
  }
}

class VDirectory extends VFileSystemEntity {
  @override
  String name;

  List<VFileSystemEntity> files;

  VDirectory(this.name, {List<VFileSystemEntity>? files}) : files = files ?? [];

  void addFile(VFileSystemEntity vfse) => files.add(vfse);

  @override
  void create([String? path]) {
    final truePath = p.join(path ?? '.', name);
    Directory(truePath).createSync(recursive: true);

    for (var fse in files) {
      fse.create(truePath);
    }
  }
}
