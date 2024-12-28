import 'package:create_spurte/src/public.dart';

import 'basic/templ.dart';

export 'basic/templ.dart';

Map<String, VFileSystemEntity Function(String path)> templates = {
  'Vanilla': vanilla
};
