import 'package:financial_tracker/Commons/exceptions/client_error.dart';

class InvariantError extends ClientError {
  InvariantError(message) : super(message) {
    name = "InvariantError";
  }
}
