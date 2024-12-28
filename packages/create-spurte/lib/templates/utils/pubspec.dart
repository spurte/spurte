import 'package:yaml_edit/yaml_edit.dart';

mixin Json {
  Map<String, dynamic> toJson();

  String toYaml() {
    final yamlEditor = YamlEditor('');
    yamlEditor.update([], toJson());
    return yamlEditor.toString();
  }
}

class Pubspec with Json {
  String name;
  String? description;
  String version;
  Uri? homepage;
  PubspecEnvironment environment;
  Map<String, String> dependencies;
  Map<String, String> devDependencies;

  Pubspec({
    required this.name,
    this.description,
    required this.version,
    this.homepage,
    required this.environment,
    required this.dependencies,
    required this.devDependencies,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'version': version,
      'homepage': homepage.toString(),
      'environment': environment.toJson(),
      'dependencies': dependencies,
      'dev_dependencies': devDependencies
    };
  }
}

class PubspecEnvironment with Json {
  String sdk;

  PubspecEnvironment({required this.sdk});

  @override
  Map<String, dynamic> toJson() {
    return {'sdk': sdk};
  }
}
