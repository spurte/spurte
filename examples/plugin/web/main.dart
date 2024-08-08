import 'package:web/web.dart';

part 'info.g.dart';

void main(List<String> args) {
  print(random);

  final element = document.createElement("div");
  element.innerHTML = "Hello Dart from Dyte!";
  document.body?.append(element);
}