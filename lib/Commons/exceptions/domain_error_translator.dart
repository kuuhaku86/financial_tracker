import 'package:financial_tracker/Commons/exceptions/invariant_error.dart';

class DomainErrorTranslator {
  Exception? translate(String error) {
    return _directories[error];
  }

  final Map<String, Exception> _directories = {
    "SOURCE.NOT_FOUND": InvariantError("source not found")
  };
}
