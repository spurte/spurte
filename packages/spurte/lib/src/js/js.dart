/// In order for this to work, Spurte needs to know the kind of project being worked on to save time
/// 
/// To do this, Spurte checks the root of the project, or any of its directories, for either a package.json or deno.json 
/// to denote the field for an NPM or Deno project respectively.
/// 
/// In any field that Spurte does not find either of the files, Spurte will serve the projects as normal.
/// If it does find it, Spurte will make use of its js package implementation to transform the file before it is sent to the server.
/// 
/// In all cases, Spurte will, in order, either 
/// - Check its configuration files for any js files specified as entrypoints for interop (by default all imports are unscoped)
/// - (experimental) Check for annotations specifying filenames to interop with (including if it is to be imported scoped or unscoped)
/// - Use the entrypoint js file (index.js or main.js) file to interop
/// 
/// ```dart
/// // TODO: Complete example
/// ```
/// 
/// Once spurte finds this file, Spurte will generate a js file to be used in the HTML to initialise the interop, either as an export or as properties on global this (js.globalThis is true)
/// 
/// If Spurte interop files are not present, you can make use of `jsigen` annotations, and Spurte will use JSIGen to generate these files before the dev server is started.
/// 
/// In production, however, this JS file will need to be bundled.
/// The js file will be included "as is" as a script tag on the produced HTML.
library spurte.js;