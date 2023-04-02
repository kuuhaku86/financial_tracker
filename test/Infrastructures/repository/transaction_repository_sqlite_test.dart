import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Infrastructures/repository/transaction_repository_sqlite.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import '../../mocks/sqlite_db.mocks.dart';

void main() {
  group("TransactionRepositorySQLite Class", () {
    const id = 123;
    const transactionId = 321;
    const transactionTypeId = 234;
    const sourceId = 345;
    const periodId = 456;
    const numberInPeriod = 13;
    const name = "transaction_repository_sqlite_test_name";
    const detail = "transaction_repository_sqlite_test_detail";
    const amount = 12000.0;
    final date = DateTime.now();
    final mapTransaction = {
      "id": id,
      "transaction_type_id": transactionTypeId,
      "source_id": sourceId,
      "name": name,
      "detail": detail,
      "amount": amount,
      "date": date.microsecondsSinceEpoch,
    };
    final mapAddTransaction = <String, Object>{
      "id": id,
      "transaction_type_id": transactionTypeId,
      "source_id": sourceId,
      "name": name,
      "detail": detail,
      "amount": amount,
      "date": date.microsecondsSinceEpoch,
    };
    final mapAddRecurringTransaction = <String, Object>{
      "id": id,
      "transaction_id": transactionId,
      "number_in_period": numberInPeriod,
      "period_id": periodId
    };
    final mapIdName = {
      "id": id,
      "name": name,
    };
    final mapRecurringTransaction = {
      "id": id,
      "transaction_id": transactionId,
      "number_in_period": numberInPeriod,
      "period_id": periodId
    };
    final transactionType = TransactionType(id: id, name: name);
    final transaction = Transaction(
        id: id,
        transactionTypeId: transactionTypeId,
        sourceId: sourceId,
        name: name,
        detail: detail,
        amount: amount,
        date: date);
    final recurringTransaction = RecurringTransaction(
        id: id,
        transactionId: transactionId,
        numberInPeriod: numberInPeriod,
        periodId: periodId);

    group("getTransactionType function", () {
      const tableName = "transaction_types";

      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => null);

        expect(
            repository.getTransactionType(id),
            throwsA(errorTranslator
                .translate(ExceptionEnum.transactionTypeNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => mapIdName);

        final result = await repository.getTransactionType(id);

        expect(result.id, transactionType.id);
        expect(result.name, transactionType.name);
      });
    });

    group("getTransactions function", () {
      const tableName = "transactions";

      test('return empty array if no record found', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getAll(tableName)).thenAnswer((_) async => []);

        final result = await repository.getTransactions();
        expect(result.length, 0);
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getAll(tableName)).thenAnswer(
            (_) async => [mapTransaction, mapTransaction, mapTransaction]);

        final result = await repository.getTransactions();
        expect(result.length, 3);
        expect(result[0].id, id);
        expect(result[0].transactionTypeId, transactionTypeId);
        expect(result[0].sourceId, sourceId);
        expect(result[0].name, name);
        expect(result[0].detail, detail);
        expect(result[0].amount, amount);
        expect(result[0].date, date);
      });
    });

    group("getTransaction function", () {
      const tableName = "transactions";

      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => null);

        expect(
            repository.getTransaction(id),
            throwsA(
                errorTranslator.translate(ExceptionEnum.transactionNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => mapTransaction);

        final result = await repository.getTransaction(id);

        expect(result.id, id);
        expect(result.transactionTypeId, transactionTypeId);
        expect(result.sourceId, sourceId);
        expect(result.name, name);
        expect(result.detail, detail);
        expect(result.amount, amount);
        expect(result.date, date);
      });
    });

    group("getTransactionTypes function", () {
      const tableName = "transaction_types";

      test('return empty array if no record found', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getAll(tableName)).thenAnswer((_) async => []);

        final result = await repository.getTransactionTypes();
        expect(result.length, 0);
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getAll(tableName))
            .thenAnswer((_) async => [mapIdName, mapIdName, mapIdName]);

        final result = await repository.getTransactionTypes();
        expect(result.length, 3);
        expect(result[0].id, id);
        expect(result[0].name, name);
      });
    });

    group("getPeriods function", () {
      const tableName = "periods";

      test('return empty array if no record found', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getAll(tableName)).thenAnswer((_) async => []);

        final result = await repository.getPeriods();
        expect(result.length, 0);
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);
        final map = {"id": id, "name": name};

        when(db.getAll(tableName)).thenAnswer((_) async => [map, map, map]);

        final result = await repository.getPeriods();
        expect(result.length, 3);
        expect(result[0].id, id);
        expect(result[0].name, name);
      });
    });

    group("getPeriod function", () {
      const tableName = "periods";

      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => null);

        expect(repository.getPeriod(id),
            throwsA(errorTranslator.translate(ExceptionEnum.periodNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer(
            (_) async => <dynamic, dynamic>{"id": id, "name": name});

        final result = await repository.getPeriod(id);

        expect(result.id, id);
        expect(result.name, name);
      });
    });

    group("getRecurringTransaction function", () {
      const tableName = "recurring_transactions";

      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id)).thenAnswer((_) async => null);

        expect(
            repository.getRecurringTransaction(id),
            throwsA(errorTranslator
                .translate(ExceptionEnum.recurringTransactionNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.get(tableName, id))
            .thenAnswer((_) async => mapRecurringTransaction);

        final result = await repository.getRecurringTransaction(id);

        expect(result.id, id);
        expect(result.transactionId, transactionId);
        expect(result.numberInPeriod, numberInPeriod);
        expect(result.periodId, periodId);
      });
    });

    group("getRecurringTransactionByTransactionId function", () {
      const tableName = "recurring_transactions";

      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getByWhere(tableName, "transaction_id = ?", [id]))
            .thenAnswer((_) async => []);

        expect(
            repository.getRecurringTransactionByTransactionId(id),
            throwsA(errorTranslator
                .translate(ExceptionEnum.recurringTransactionNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getByWhere(tableName, "transaction_id = ?", [id]))
            .thenAnswer((_) async => [mapRecurringTransaction]);

        final result =
            await repository.getRecurringTransactionByTransactionId(id);

        expect(result.id, id);
        expect(result.transactionId, transactionId);
        expect(result.numberInPeriod, numberInPeriod);
        expect(result.periodId, periodId);
      });
    });

    group("getTransactionsBySourceId function", () {
      const tableName = "transactions";

      test('throws exception if not found any record', () {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getByWhere(tableName, "source_id = ?", [id]))
            .thenAnswer((_) async => []);

        expect(
            repository.getTransactionsBySourceId(id),
            throwsA(
                errorTranslator.translate(ExceptionEnum.transactionNotFound)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.getByWhere(tableName, "source_id = ?", [id]))
            .thenAnswer((_) async => [mapTransaction]);

        final result = await repository.getTransactionsBySourceId(id);

        expect(result[0].id, id);
        expect(result[0].transactionTypeId, transactionTypeId);
        expect(result[0].sourceId, sourceId);
        expect(result[0].name, name);
        expect(result[0].detail, detail);
        expect(result[0].amount, amount);
        expect(result[0].date, date);
      });
    });

    group("addTransaction function", () {
      const tableName = "transactions";

      test('throw error if insertion failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.insert(tableName, mapAddTransaction))
            .thenAnswer((_) async => 0);

        expect(
            repository.addTransaction(mapAddTransaction),
            throwsA(
                errorTranslator.translate(ExceptionEnum.addTransactionFailed)));
      });

      test('return Transaction object when insertion success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.insert(tableName, mapAddTransaction))
            .thenAnswer((_) async => id);
        when(db.get(tableName, id)).thenAnswer((_) async => mapTransaction);

        var result = await repository.addTransaction(mapAddTransaction);
        expect(result.id, id);
        expect(result.transactionTypeId, transactionTypeId);
        expect(result.sourceId, sourceId);
        expect(result.name, name);
        expect(result.detail, detail);
        expect(result.amount, amount);
        expect(result.date, date);
      });
    });

    group("addRecurringTransaction function", () {
      const tableName = "recurring_transactions";

      test('throw error if insertion failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.insert(tableName, mapAddRecurringTransaction))
            .thenAnswer((_) async => 0);

        expect(
            repository.addRecurringTransaction(mapAddRecurringTransaction),
            throwsA(errorTranslator
                .translate(ExceptionEnum.addRecurringTransactionFailed)));
      });

      test('return Recurring Transaction object when insertion success',
          () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.insert(tableName, mapAddRecurringTransaction))
            .thenAnswer((_) async => id);
        when(db.get(tableName, id))
            .thenAnswer((_) async => mapRecurringTransaction);

        var result = await repository
            .addRecurringTransaction(mapAddRecurringTransaction);
        expect(result.id, id);
        expect(result.transactionId, transactionId);
        expect(result.numberInPeriod, numberInPeriod);
        expect(result.periodId, periodId);
      });
    });

    group("deleteTransaction function", () {
      String tableName = "transactions";

      test('throw error if deletion failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.delete(tableName, id)).thenAnswer((_) async => 0);

        expect(
            repository.deleteTransaction(id),
            throwsA(errorTranslator
                .translate(ExceptionEnum.deleteTransactionFailed)));
      });

      test('return Transaction object when deletion success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.delete(tableName, id)).thenAnswer((_) async => id);

        expect(repository.deleteTransaction(id), isA<Future<void>>());
      });
    });

    group("deleteRecurringTransaction function", () {
      String tableName = "recurring_transactions";

      test('throw error if deletion failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.delete(tableName, id)).thenAnswer((_) async => 0);

        expect(
            repository.deleteRecurringTransaction(id),
            throwsA(errorTranslator
                .translate(ExceptionEnum.deleteRecurringTransactionFailed)));
      });

      test('return RecurringTransaction object when deletion success',
          () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.delete(tableName, id)).thenAnswer((_) async => id);

        expect(repository.deleteRecurringTransaction(id), isA<Future<void>>());
      });
    });

    group("updateTransaction function", () {
      String tableName = "transactions";

      test('throw error if update failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.update(tableName, transaction)).thenAnswer((_) async => 0);

        expect(
            repository.updateTransaction(transaction),
            throwsA(errorTranslator
                .translate(ExceptionEnum.updateTransactionFailed)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.update(tableName, transaction)).thenAnswer((_) async => id);

        expect(repository.updateTransaction(transaction), isA<Future<void>>());
      });
    });

    group("updateRecurringTransaction function", () {
      String tableName = "recurring_transactions";

      test('throw error if update failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.update(tableName, recurringTransaction))
            .thenAnswer((_) async => 0);

        expect(
            repository.updateRecurringTransaction(recurringTransaction),
            throwsA(errorTranslator
                .translate(ExceptionEnum.updateRecurringTransactionFailed)));
      });

      test('execution success', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);

        when(db.update(tableName, recurringTransaction))
            .thenAnswer((_) async => id);

        expect(repository.updateRecurringTransaction(recurringTransaction),
            isA<Future<void>>());
      });
    });
  });
}
