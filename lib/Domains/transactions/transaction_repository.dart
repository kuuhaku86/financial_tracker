import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';

import 'entities/transaction.dart';

class TransactionRepository {
  Future<TransactionType> getTransactionType(int transactionTypeId) async {
    throw Exception("Not Implemented");
  }

  Future<List<Transaction>> getTransactions() async {
    throw Exception("Not Implemented");
  }

  Future<Transaction> getTransaction(int transactionId) async {
    throw Exception("Not Implemented");
  }

  Future<Transaction> addTransaction(AddTransaction payload) async {
    throw Exception("Not Implemented");
  }
}
