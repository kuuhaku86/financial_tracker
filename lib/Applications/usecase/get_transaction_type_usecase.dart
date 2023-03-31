import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetTransactionTypeUsecase {
  TransactionRepository transactionRepository;

  GetTransactionTypeUsecase({required this.transactionRepository});

  Future<TransactionType> execute(int transactionTypeId) async {
    return await transactionRepository.getTransactionType(transactionTypeId);
  }
}
