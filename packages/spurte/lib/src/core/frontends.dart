import 'dart:io';

import 'package:frontend_server_client/frontend_server_client.dart';

class Dart2JsFrontendServerClient implements FrontendServerClient {
  Dart2JsFrontendServerClient._(
    // FrontendServerClient server
  );
  
  static Future<Dart2JsFrontendServerClient> start() async {
    // var feServer = await FrontendServerClient.start(
    //   entrypoint,
    //   outputDillPath,
    //   platformKernel ?? _dartdevcPlatformKernel,
    //   debug: debug,
    //   enableHttpUris: enableHttpUris,
    //   fileSystemRoots: fileSystemRoots,
    //   fileSystemScheme: fileSystemScheme,
    //   frontendServerPath: frontendServerPath,
    //   packagesJson: packagesJson,
    //   sdkRoot: sdkRoot,
    //   target: 'dartdevc',
    //   verbose: verbose,
    // );
    return Dart2JsFrontendServerClient._();
  }


  @override
  void accept() {
    // TODO: implement accept
  }

  @override
  Future<CompileResult> compile([List<Uri>? invalidatedUris]) {
    // TODO: implement compile
    throw UnimplementedError();
  }

  @override
  Future<CompileResult> compileExpression({required String expression, required List<String> definitions, required bool isStatic, required String klass, required String libraryUri, required List<String> typeDefinitions}) {
    // TODO: implement compileExpression
    throw UnimplementedError();
  }

  @override
  Future<CompileResult> compileExpressionToJs({required String expression, required int column, required Map<String, String> jsFrameValues, required Map<String, String> jsModules, required String libraryUri, required int line, required String moduleName}) {
    // TODO: implement compileExpressionToJs
    throw UnimplementedError();
  }

  @override
  bool kill({ProcessSignal processSignal = ProcessSignal.sigterm}) {
    // TODO: implement kill
    throw UnimplementedError();
  }

  @override
  Future<void> reject() {
    // TODO: implement reject
    throw UnimplementedError();
  }

  @override
  void reset() {
    // TODO: implement reset
  }

  @override
  Future<int> shutdown() {
    // TODO: implement shutdown
    throw UnimplementedError();
  }
  
}

class Dart2WasmFrontendServerClient implements FrontendServerClient {
  @override
  void accept() {
    // TODO: implement accept
  }

  @override
  Future<CompileResult> compile([List<Uri>? invalidatedUris]) {
    // TODO: implement compile
    throw UnimplementedError();
  }

  @override
  Future<CompileResult> compileExpression({required String expression, required List<String> definitions, required bool isStatic, required String klass, required String libraryUri, required List<String> typeDefinitions}) {
    // TODO: implement compileExpression
    throw UnimplementedError();
  }

  @override
  Future<CompileResult> compileExpressionToJs({required String expression, required int column, required Map<String, String> jsFrameValues, required Map<String, String> jsModules, required String libraryUri, required int line, required String moduleName}) {
    // TODO: implement compileExpressionToJs
    throw UnimplementedError();
  }

  @override
  bool kill({ProcessSignal processSignal = ProcessSignal.sigterm}) {
    // TODO: implement kill
    throw UnimplementedError();
  }

  @override
  Future<void> reject() {
    // TODO: implement reject
    throw UnimplementedError();
  }

  @override
  void reset() {
    // TODO: implement reset
  }

  @override
  Future<int> shutdown() {
    // TODO: implement shutdown
    throw UnimplementedError();
  }

}