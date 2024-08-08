import '../plugins/plugins.dart';

class DytePluginResult {
  String? path;
  String? src;

  DytePluginResult({
    this.path,
    this.src
  });
}

class DytePlugin {
  final String? name;
  final DyteResolve? resolve;
  final DyteLoad? load;
  final DyteSetup? setup;
  final DyteTeardown? teardown;
  final DyteBeforeLoad? beforeLoad;
  final DyteAfterLoad? afterLoad;
  
  DytePlugin({
    this.name, this.resolve, this.load, this.setup, this.teardown, this.beforeLoad, this.afterLoad
  });
}