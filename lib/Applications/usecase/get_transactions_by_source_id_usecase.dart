import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetTransactionsBySourceIdUsecase {
  TransactionRepository transactionRepository;

  GetTransactionsBySourceIdUsecase({required this.transactionRepository});

  Future<List<Transaction>> execute(int sourceId) async {
    return await transactionRepository.getTransactionsBySourceId(sourceId);
  }
}
