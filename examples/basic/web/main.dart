import 'package:web/web.dart';

void main(List<String> args) {
  print("Hello Dart!");

  final element = document.createElement("div");
  element.innerHTML = "Hello Dart from Spurtessss!";
  document.body?.append(element);
}