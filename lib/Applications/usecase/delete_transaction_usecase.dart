import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class DeleteTransactionUsecase {
  TransactionRepository transactionRepository;

  DeleteTransactionUsecase({required this.transactionRepository});

  Future<void> execute(Transaction transaction) async {
    RecurringTransaction? recurringTransaction;
    try {
      recurringTransaction = await transactionRepository
          .getRecurringTransactionByTransactionId(transaction.id);
    } catch (e) {
      // if transaction doesn't has any recurring transaction
      recurringTransaction = null;
    }

    if (recurringTransaction != null) {
      await transactionRepository
          .deleteRecurringTransaction(recurringTransaction.id);
    }

    await transactionRepository.deleteTransaction(transaction.id);
  }
}
