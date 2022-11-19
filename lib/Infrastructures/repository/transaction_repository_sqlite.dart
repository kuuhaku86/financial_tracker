import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class TransactionRepositorySQLite extends TransactionRepository {
  Future<TransactionType> getTransactionType(int transactionTypeId) {
    throw Exception("Not Implemented");
  }

  Future<Transaction> addTransaction(AddTransaction payload) {
    throw Exception("Not Implemented");
  }
}