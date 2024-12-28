import 'package:create_spurte/src/gen/version.dart';
import 'package:create_spurte/src/public.dart';
import 'package:create_spurte/templates/utils/pubspec.dart';

VFileSystemEntity vanilla(String name) => VDirectory(name, files: [
      VDirectory('web')
        ..addFile(VFile('main.dart', contents: """import 'package:web/web.dart';

void main(List<String> args) {
  final element = document.createElement("div");
  element.innerHTML = "Hello Dart from Spurte!";
  document.body?.append(element);
}""")),
      VFile('spurte.config.json', contents: '{}'),
      VFile('pubspec.yaml',
          contents: Pubspec(
              name: name,
              version: '1.0.0',
              environment: PubspecEnvironment(sdk: '^3.4.0'),
              dependencies: {},
              devDependencies: {'spurte': version}).toYaml()),
      VFile('index.html', contents: '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$name</title>
    <script defer src="web/main.dart.js" type="application/javascript"></script>
</head>
<body>
    <div id="app"></div>
</body>
</html>''')
    ]);
