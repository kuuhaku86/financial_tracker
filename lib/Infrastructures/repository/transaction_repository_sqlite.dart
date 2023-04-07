import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
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

    return TransactionType.fromMap(record);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    var records = await db.getAll("transactions");

    return records.map((record) => Transaction.fromMap(record)).toList();
  }

  @override
  Future<Transaction> getTransaction(int transactionId) async {
    var record = await db.get("transactions", transactionId);

    if (record == null) {
      throw errorTranslator.translate(ExceptionEnum.transactionNotFound);
    }

    return Transaction.fromMap(record);
  }

  @override
  Future<List<TransactionType>> getTransactionTypes() async {
    var records = await db.getAll("transaction_types");

    return records.map((record) => TransactionType.fromMap(record)).toList();
  }

  @override
  Future<List<Period>> getPeriods() async {
    var records = await db.getAll("periods");

    return records.map((record) => Period.fromMap(record)).toList();
  }

  @override
  Future<Period> getPeriod(int periodId) async {
    var record = await db.get("periods", periodId);

    if (record == null) {
      throw errorTranslator.translate(ExceptionEnum.periodNotFound);
    }

    return Period.fromMap(record);
  }

  @override
  Future<RecurringTransaction> getRecurringTransaction(
      int recurringTransactionId) async {
    var record = await db.get("recurring_transactions", recurringTransactionId);

    if (record == null) {
      throw errorTranslator
          .translate(ExceptionEnum.recurringTransactionNotFound);
    }

    return RecurringTransaction.fromMap(record);
  }

  @override
  Future<List<RecurringTransaction>> getRecurringTransactions() async {
    var records = await db.getAll("recurring_transactions");

    return records
        .map((record) => RecurringTransaction.fromMap(record))
        .toList();
  }

  @override
  Future<RecurringTransaction> getRecurringTransactionByTransactionId(
      int transactionId) async {
    var record = await db.getByWhere(
        "recurring_transactions", "transaction_id = ?", [transactionId]);

    if (record.isEmpty) {
      throw errorTranslator
          .translate(ExceptionEnum.recurringTransactionNotFound);
    }

    return RecurringTransaction.fromMap(record.first!);
  }

  @override
  Future<List<Transaction>> getTransactionsBySourceId(int sourceId) async {
    var record =
        await db.getByWhere("transactions", "source_id = ?", [sourceId]);

    if (record.isEmpty) {
      throw errorTranslator.translate(ExceptionEnum.transactionNotFound);
    }

    return record.map((item) => Transaction.fromMap(item!)).toList();
  }

  @override
  Future<Transaction> addTransaction(Map<String, Object> map) async {
    map["date"] = DateTime.now().microsecondsSinceEpoch;
    int id = await db.insert("transactions", map);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.addTransactionFailed);
    }

    return await getTransaction(id);
  }

  @override
  Future<RecurringTransaction> addRecurringTransaction(
      Map<String, Object> map) async {
    int id = await db.insert("recurring_transactions", map);

    if (id == 0) {
      throw errorTranslator
          .translate(ExceptionEnum.addRecurringTransactionFailed);
    }

    return await getRecurringTransaction(id);
  }

  @override
  Future<void> deleteTransaction(int transactionId) async {
    int id = await db.delete("transactions", transactionId);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.deleteTransactionFailed);
    }
  }

  @override
  Future<void> deleteRecurringTransaction(int recurringTransactionId) async {
    int id = await db.delete("recurring_transactions", recurringTransactionId);

    if (id == 0) {
      throw errorTranslator
          .translate(ExceptionEnum.deleteRecurringTransactionFailed);
    }
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    int id = await db.update("transactions", transaction);

    if (id == 0) {
      throw errorTranslator.translate(ExceptionEnum.updateTransactionFailed);
    }
  }

  @override
  Future<void> updateRecurringTransaction(
      RecurringTransaction recurringTransaction) async {
    int id = await db.update("recurring_transactions", recurringTransaction);

    if (id == 0) {
      throw errorTranslator
          .translate(ExceptionEnum.updateRecurringTransactionFailed);
    }
  }

  @override
  Future<List<Transaction>> getTransactionsWithTimeRange(
      int startTime, int endTime) async {
    var record = await db.getByWhere(
        "transactions", "date >= ? AND date <= ?", [startTime, endTime]);

    return record.map((item) => Transaction.fromMap(item!)).toList();
  }
}
