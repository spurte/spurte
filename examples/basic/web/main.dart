import 'package:web/web.dart';

void main(List<String> args) {
  final element = document.createElement("div");
  element.innerHTML = "Hello Dart from Spurte!";
  document.body?.append(element);
}
