import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetTransactionsUsecase {
  TransactionRepository transactionRepository;

  GetTransactionsUsecase({required this.transactionRepository});

  Future<List<Transaction>> execute() async {
    return await transactionRepository.getTransactions();
  }
}
