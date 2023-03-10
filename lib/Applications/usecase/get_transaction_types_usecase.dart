import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetTransactionTypesUsecase {
  TransactionRepository transactionRepository;

  GetTransactionTypesUsecase({required this.transactionRepository});

  Future<List<TransactionType>> execute() async {
    return await transactionRepository.getTransactionTypes();
  }
}
