class SpurteException implements Exception {
  String message;
  
  bool usage;
  
  int exitCode;

  SpurteException(this.message, {
    this.exitCode = 1,
    this.usage = false
  });
}