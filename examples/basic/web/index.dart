

import 'package:web/web.dart';

void main(List<String> args) {
  print("Hello Dart!");

  final element = document.getElementById("#app") as HTMLElement;
  element.appendChild(
    document.createElement("div")..innerHTML = "Hello from Dyte"
  );
}