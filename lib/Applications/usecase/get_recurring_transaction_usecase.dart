import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetRecurringTransactionUsecase {
  TransactionRepository transactionRepository;

  GetRecurringTransactionUsecase({required this.transactionRepository});

  Future<RecurringTransaction> execute(
      int recurringTransactionId) async {
    return await transactionRepository
        .getRecurringTransaction(recurringTransactionId);
  }
}
