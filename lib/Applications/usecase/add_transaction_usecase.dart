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

    return await transactionRepository.addTransaction(payload);
  }
}
