import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

final pubspec = File('pubspec.yaml').readAsStringSync();
final yaml = loadYaml(pubspec);

final String version = yaml['version'];

void main(List<String> args) {
  final v = Version.parse(version);
  print("Current Version: $v");

  if (args.contains("--major")) {
    v.bump(VersionType.major);
    print("New Version: $v");
  } else if (args.contains("--minor")) {
    v.bump(VersionType.minor);
    print("New Version: $v");
  } else if (args.contains("--patch")) {
    v.bump(VersionType.patch);
    print("New Version: $v");
  }
  print("Syncing Version...");
  syncVersion(args.contains('--pkl'));
  print("\nDone!");
}

void syncVersion([bool pkl = false]) async {
  // write to pubspec
  final yamlEditor = YamlEditor(pubspec);
  yamlEditor.update(['version'], version);
  await File('pubspec.yaml').writeAsString(yamlEditor.toString());

  // write to version.dart for cli
  var versionFilePath = "lib/src/gen/version.dart";
  var versionFile = await File(versionFilePath).create(recursive: true);
  versionFile.writeAsString(
    """
const String version = "$version";
""");

  // if pkl, write to pkl file
}


enum VersionType { major, minor, patch }

class Version {
  int major;
  int minor;
  int patch;
  String? pre;
  String? build;

  Version(this.major, this.minor, this.patch, [this.pre, this.build]);

  factory Version.parse(String v) {
    final parts = v.split(".");
    var prerelease = parts.length > 2 ? parts[2].split("-").last : null;
    if (prerelease == parts[2]) prerelease = null;
    var build = parts.length > 2 ? parts[2].split("+").last : null;
    if (build == parts[2]) build = null;
    return Version(
      int.parse(parts[0]), 
      int.parse(parts.length > 1 ? parts[1] : "0"), 
      int.parse(parts.length > 2 ? parts[2].split("-").first.split("+").first : "0"),
      prerelease,
      build
    );
  }

  
  @override
  String toString() {
    return "$major.$minor.$patch${pre == null ? "" : "-$pre"}${build == null ? "" : "+$build"}";
  }

  void bump(VersionType type, [int? newVersion]) {
    switch (type) {
      case VersionType.patch:
        patch++;
        break;
      case VersionType.major:
        major++;
        minor = 0;
        patch = 0;
        break;
      case VersionType.minor:
        minor++;
        patch = 0;
        break;
    }
  }
}