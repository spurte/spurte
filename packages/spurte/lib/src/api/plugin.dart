/// TODO: Add more documentation to this page

import '../plugins/plugins.dart';

class SpurtePluginResult {
  String? path;
  String? src;

  SpurtePluginResult({
    this.path,
    this.src
  });
}

/// The base class for defining a spurte plugin
/// 
class SpurtePlugin {
  final String? name;
  final SpurteResolve? resolve;
  final SpurteLoad? load;
  final SpurteSetup? setup;
  final SpurteTeardown? teardown;
  final SpurteBeforeLoad? beforeLoad;
  final SpurteAfterLoad? afterLoad;
  
  SpurtePlugin({
    this.name, this.resolve, this.load, this.setup, this.teardown, this.beforeLoad, this.afterLoad
  });
}