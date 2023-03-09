import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetTransactionUsecase {
  TransactionRepository transactionRepository;

  GetTransactionUsecase({required this.transactionRepository});

  Future<Transaction> execute({required int transactionId}) async {
    return await transactionRepository.getTransaction(transactionId);
  }
}