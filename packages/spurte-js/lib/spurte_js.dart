/// Library for interfacing with JS for handling JS and Dart files in Spurte
/// 
/// When handling normal files (files not involving a JS package manager or runtime), Spurte can handle these files easily without the need for any processing before-hand.
/// This can be done by just simply serving the files
/// 
/// However, when it comes to files associated with a project, such as NPM or Deno, these files contain imports and packages that cannot be so easily resolved.
/// We could just create a resolver that can get these package names if it was a purely javascript project, but it may not always be
/// 
/// In order to resolve this, a separate package has been implemented to interface with this, where we can easily transform and build JS files in Dart, to be used on the web platform
/// 
/// To do this, we will use [esbuild](https://esbuild.github.io/), because of it's simplicity, speed, and also because of future plans of interfacing with it directly via FFI.
/// 
/// As of now the project requires node to run in order for it to be used. In the future, esbuild will be interfaced via its golang api instead via FFI (at least once the native assets API is completely stable).
library spurte.js;