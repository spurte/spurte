import 'package:create_spurte/src/gen/version.dart';
import 'package:create_spurte/src/public.dart';
import 'package:create_spurte/templates/utils/pubspec.dart';

VFileSystemEntity vanilla(String name) => VDirectory(
  name,
  files: [
    VDirectory('web')
      ..addFile(VFile(
        'main.dart',
        contents: ''
      )),
    VFile('spurte.config.json'),
    VFile('pubspec.yaml', contents: Pubspec(
      name: name, 
      version: '1.0.0', 
      environment: PubspecEnvironment(sdk: '^3.4.0'), 
      dependencies: {}, 
      devDependencies: {
        'spurte': version
      }
    ).toYaml()),
    VFile('index.html', )
  ]
);