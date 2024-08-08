import 'package:dyte/dyte.dart';

final plugin = DytePlugin(
  resolve: (id) {
    if (id.name.endsWith(".txt")) {
      return "text";
    }

    return null;
  },

  load: (id, source, [options]) {
    switch (id) {
      case "text":
        final srclines = source.split("\n").map((e) {
          final parts = e.split(": ");
          return "final ${parts[0]} = ${parts[1]};";
        });
        return DytePluginResult(
          src: srclines.join("\n\n"),
          path: id.replaceFirst(".txt", ".g.dart")
        );
      default:
        return DytePluginResult();
    }
  },
);