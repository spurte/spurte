
/// In this module we initiate HMR
/// 
/// 
import 'package:embed_annotation/embed_annotation.dart';

part 'hmr.g.dart';

@EmbedStr('./hmr_client.js')
const hmr_client_script = _$hmr_client_script;
