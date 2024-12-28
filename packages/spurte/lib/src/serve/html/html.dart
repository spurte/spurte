import 'package:html/dom.dart';
import 'package:html/parser.dart';

String addScriptToHtml(String html, String script, {bool module = false}) {
  final parsedHtml = parse(html);
  final el = Element.tag('script')..innerHtml = script;
  if (module) el.attributes.addAll({'type': 'module'});
  parsedHtml.head?.children.add(el);

  return parsedHtml.outerHtml;
}

String addScriptsToHtml(String html, List<String> scripts,
    {bool module = false}) {
  final parsedHtml = parse(html);
  final scriptElements = scripts.map((s) {
    final el = Element.tag('script')..innerHtml = s;
    if (module) el.attributes.addAll({'type': 'module'});
    return el;
  });
  parsedHtml.head?.children.addAll(scriptElements);

  return parsedHtml.outerHtml;
}
