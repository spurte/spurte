import 'dart:io';

import 'package:path/path.dart' as p;

String wasmJsTemplate(String name, [String? importFile, String? exportFile]) {
  return exportFile == null ? '''(async function () {
    let dart2wasm_runtime;
    let moduleInstance;
    try {
        const dartModulePromise = WebAssembly.compileStreaming(fetch('$name.wasm'));
        const imports = ${importFile == null ? "{}" : "await import('$importFile')"};
        dart2wasm_runtime = await import('./$name.mjs');
        moduleInstance = await dart2wasm_runtime.instantiate(dartModulePromise, imports);
    } catch (exception) {
        console.error(`Failed to fetch and instantiate wasm module: \${exception}`);
        console.error('See https://dart.dev/web/wasm for more information.');
    }

    if (moduleInstance) {
        try {
            await dart2wasm_runtime.invoke(moduleInstance);
        } catch (exception) {
            console.error(`Exception while invoking test: \${exception}`);
        }
    }
})();
''' : '''import * as dart2wasm_runtime from './$name.mjs';
${importFile == null ? "const imports = {};" : "import importObj from '$importFile'; const imports = importObj;"}

export function instantiate() {
  let moduleInstance;
  try {
      const dartModulePromise = WebAssembly.compileStreaming(fetch('$name.wasm'));
      moduleInstance = await dart2wasm_runtime.instantiate(dartModulePromise, imports);
  } catch (exception) {
      console.error(`Failed to fetch and instantiate wasm module: \${exception}`);
      console.error('See https://dart.dev/web/wasm for more information.');
  }

  return moduleInstance;
}

export function main(instance) {
  if (moduleInstance) {
      try {
          await dart2wasm_runtime.invoke(moduleInstance);
      } catch (exception) {
          console.error(`Exception while invoking test: \${exception}`);
      }
  }
}

main(instantiate());
''';
}

Future<void> writeWasm(String name, Directory distDir, [String? importFile, String? exportFile]) async {
  String template = wasmJsTemplate(name, importFile == null ? null : p.basename(importFile), exportFile);

  String distFile = exportFile == null ? "$name.dart.js" : "$name.dart.lib.js";
  await File(p.join(distDir.absolute.path, distFile)).writeAsString(template);

  if (exportFile != null) {
    await File(exportFile).copy(p.join(distDir.absolute.path, '$name.dart.js'));
  }

  if (importFile != null) {
    await File(importFile).copy(p.join(distDir.absolute.path, p.basename(importFile)));
  }
}