import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class AddTransactionUsecase {
  SourceRepository sourceRepository;
  TransactionRepository transactionRepository;

  AddTransactionUsecase(
      {required this.transactionRepository, required this.sourceRepository});

  Future<Transaction> execute(AddTransaction payload) async {
    await sourceRepository.getSource(payload.sourceId);
    await transactionRepository.getTransactionType(payload.transactionTypeId);
    if (payload.isRecurring) {
      await transactionRepository.getPeriod(payload.period!.id);
    }

    final result = await transactionRepository.addTransaction(payload);

    if (payload.isRecurring) {
      await transactionRepository.addRecurringTransaction(
          AddRecurringTransaction(
              transactionId: result.id,
              numberInPeriod: payload.numberInPeriod!,
              periodId: payload.period!.id));
    }

    return result;
  }
}
