import 'package:financial_tracker/Domains/sources/source_repository.dart';
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

    final result = await transactionRepository.addTransaction(<String, Object>{
      "transaction_type_id": payload.transactionTypeId,
      "source_id": payload.sourceId,
      "name": payload.name,
      "amount": payload.amount,
      "detail": payload.detail,
    });

    if (payload.isRecurring) {
      await transactionRepository.addRecurringTransaction(<String, Object>{
        "transaction_id": result.id,
        "number_in_period": payload.numberInPeriod!,
        "period_id": payload.period!.id
      });
    }

    return result;
  }
}
