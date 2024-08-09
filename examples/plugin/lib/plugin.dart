import 'package:spurte/spurte.dart';

final plugin = SpurtePlugin(
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
        // return for text id
        return SpurtePluginResult(
          src: srclines.join("\n\n"),
          path: options?.path.replaceFirst(".txt", ".g.dart")
        );
      default:
        // return default
        return SpurtePluginResult();
    }
  },
);