import 'package:financial_tracker/Commons/exceptions/invariant_error.dart';

class DomainErrorTranslator {
  Exception translate(ExceptionEnum exceptionEnum) {
    return _directories[exceptionEnum] ?? Exception("Something is wrong");
  }

  final Map<ExceptionEnum, Exception> _directories = {
    ExceptionEnum.sourceNotFound: InvariantError("Source not found"),
    ExceptionEnum.transactionNotFound: InvariantError("Transaction not found"),
    ExceptionEnum.transactionTypeNotFound:
        InvariantError("Transaction type not found"),
    ExceptionEnum.recurringTransactionNotFound:
        InvariantError("Recurring transaction not found"),
    ExceptionEnum.periodNotFound: InvariantError("Period not found"),
    ExceptionEnum.addTransactionFailed:
        InvariantError("Add transaction failed"),
    ExceptionEnum.addRecurringTransactionFailed:
        InvariantError("Add recurring transaction failed"),
    ExceptionEnum.addSourceFailed: InvariantError("Add source failed"),
    ExceptionEnum.deleteSourceFailed: InvariantError("Delete source failed"),
    ExceptionEnum.updateSourceFailed: InvariantError("Update source failed"),
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
  deleteSourceFailed,
  updateSourceFailed,
}
