class ClientError implements Exception {
  String message;
  String name = "ClientError";
  ClientError(this.message);
}
