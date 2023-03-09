import 'package:financial_tracker/Commons/exceptions/invariant_error.dart';

class DomainErrorTranslator {
  Exception translate(ExceptionEnum exceptionEnum) {
    return _directories[exceptionEnum] ?? Exception("Something is wrong");
  }

  final Map<ExceptionEnum, Exception> _directories = {
    ExceptionEnum.sourceNotFound: InvariantError("source not found"),
    ExceptionEnum.transactionNotFound: InvariantError("transaction not found"),
  };
}

enum ExceptionEnum { sourceNotFound, transactionNotFound }
