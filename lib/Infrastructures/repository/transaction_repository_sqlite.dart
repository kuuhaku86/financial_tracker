import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';
import 'package:financial_tracker/Infrastructures/database/sqlite/db.dart';

class TransactionRepositorySQLite extends TransactionRepository {
  late SqliteDB db;
  late DomainErrorTranslator errorTranslator;

  TransactionRepositorySQLite(
      {required this.db, required this.errorTranslator});

  @override
  Future<TransactionType> getTransactionType(int transactionTypeId) async {
    var record = await db.get("transaction_types", transactionTypeId);

    if (record == null) {
      throw errorTranslator.translate(ExceptionEnum.transactionTypeNotFound);
    }

    return TransactionType.fromMap(record as Map<String, Object>);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    var records = await db.getAll("transactions");

    return records
        .map((record) => Transaction.fromMap(record as Map<String, Object>))
        .toList();
  }

  @override
  Future<Transaction> getTransaction(int transactionId) async {
    var record = await db.get("transactions", transactionId);

    if (record == null) {
      throw errorTranslator.translate(ExceptionEnum.transactionNotFound);
    }

    return Transaction.fromMap(record as Map<String, Object>);
  }

  @override
  Future<List<TransactionType>> getTransactionTypes() async {
    var records = await db.getAll("transaction_types");

    return records
        .map((record) => TransactionType.fromMap(record as Map<String, Object>))
        .toList();
  }

  @override
  Future<List<Period>> getPeriods() async {
    var records = await db.getAll("transaction_periods");

    return records
        .map((record) => Period.fromMap(record as Map<String, Object>))
        .toList();
  }

  @override
  Future<Period> getPeriod(int periodId) async {
    var record = await db.get("periods", periodId);

    if (record == null) {
      throw errorTranslator.translate(ExceptionEnum.periodNotFound);
    }

    return Period.fromMap(record as Map<String, Object>);
  }

  @override
  Future<RecurringTransaction> getRecurringTransaction(
      int recurringTransactionId) async {
    var record = await db.get("recurring_transactions", recurringTransactionId);

    if (record == null) {
      throw errorTranslator
          .translate(ExceptionEnum.recurringTransactionNotFound);
    }

    return RecurringTransaction.fromMap(record as Map<String, Object>);
  }

  @override
  Future<Transaction> addTransaction(AddTransaction payload) async {
    int id = await db.insert("transactions", payload);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.addTransactionFailed);
    }

    return await getTransaction(id);
  }

  @override
  Future<RecurringTransaction> addRecurringTransaction(
      AddRecurringTransaction payload) async {
    int id = await db.insert("recurring_transactions", payload);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.addTransactionFailed);
    }

    return await getRecurringTransaction(id);
  }
}
