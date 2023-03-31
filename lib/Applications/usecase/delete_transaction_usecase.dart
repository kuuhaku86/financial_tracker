import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class DeleteTransactionUsecase {
  TransactionRepository transactionRepository;

  DeleteTransactionUsecase({required this.transactionRepository});

  Future<void> execute(Transaction transaction) async {
    try {
      RecurringTransaction recurringTransaction = await transactionRepository
          .getRecurringTransactionByTransactionId(transaction.id);
      await transactionRepository
          .deleteRecurringTransaction(recurringTransaction.id);
    } catch (e) {
      // if transaction doesn't has any recurring transaction
    }

    await transactionRepository.deleteTransaction(transaction.id);
  }
}
