import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetRecurringTransactionByTransactionIdUsecase {
  TransactionRepository transactionRepository;

  GetRecurringTransactionByTransactionIdUsecase(
      {required this.transactionRepository});

  Future<RecurringTransaction> execute({required int transactionId}) async {
    return await transactionRepository
        .getRecurringTransactionByTransactionId(transactionId);
  }
}
