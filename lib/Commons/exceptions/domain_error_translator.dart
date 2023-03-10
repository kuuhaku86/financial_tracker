import 'package:financial_tracker/Commons/exceptions/invariant_error.dart';

class DomainErrorTranslator {
  Exception translate(ExceptionEnum exceptionEnum) {
    return _directories[exceptionEnum] ?? Exception("Something is wrong");
  }

  final Map<ExceptionEnum, Exception> _directories = {
    ExceptionEnum.sourceNotFound: InvariantError("source not found"),
    ExceptionEnum.transactionNotFound: InvariantError("transaction not found"),
    ExceptionEnum.transactionTypeNotFound:
        InvariantError("transaction type not found"),
    ExceptionEnum.recurringTransactionNotFound:
        InvariantError("recurring transaction not found"),
    ExceptionEnum.periodNotFound: InvariantError("period not found"),
    ExceptionEnum.addTransactionFailed:
        InvariantError("add transaction failed"),
    ExceptionEnum.addRecurringTransactionFailed:
        InvariantError("add recurring transaction failed"),
    ExceptionEnum.addSourceFailed: InvariantError("add source failed"),
  };
}

enum ExceptionEnum {
  sourceNotFound,
  transactionNotFound,
  transactionTypeNotFound,
  recurringTransactionNotFound,
  periodNotFound,
  addTransactionFailed,
  addRecurringTransactionFailed,
  addSourceFailed,
}
