import 'package:financial_tracker/Domains/transactions/entities/add_recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
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

  Future<List<TransactionType>> getTransactionTypes() async {
    throw Exception("Not Implemented");
  }

  Future<List<Period>> getPeriods() async {
    throw Exception("Not Implemented");
  }

  Future<Period> getPeriod(int periodId) async {
    throw Exception("Not Implemented");
  }

  Future<RecurringTransaction> getRecurringTransaction(
      int recurringTransactionId) async {
    throw Exception("Not Implemented");
  }

  Future<RecurringTransaction> getRecurringTransactionByTransactionId(
      int transactionId) async {
    throw Exception("Not Implemented");
  }

  Future<Transaction> addTransaction(Map<String, Object> map) async {
    throw Exception("Not Implemented");
  }

  Future<RecurringTransaction> addRecurringTransaction(
      Map<String, Object> map) async {
    throw Exception("Not Implemented");
  }
}
