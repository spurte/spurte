import 'package:create_spurte/src/public.dart';

VFileSystemEntity vanilla(String dir) => VDirectory(
  dir,
  files: [
    VDirectory('web')
      ..addFile(VFile(
        'main.dart',
        contents: ''
      )),
    VFile('spurte.config.json'),
    VFile('pubspec.yaml'),
    VFile('index.html', )
  ]
);