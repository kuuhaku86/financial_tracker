import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
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
    const explanation = "transaction_repository_sqlite_test_explanation";
    const amount = 12000.0;
    final date = DateTime.now();
    final mapAddTransaction = <String, Object>{
      "id": id,
      "transaction_type_id": transactionTypeId,
      "source_id": sourceId,
      "name": name,
      "explanation": explanation,
      "amount": amount,
      "date": date.microsecondsSinceEpoch,
    };
    final mapAddRecurringTransaction = <String, Object>{
      "id": id,
      "transaction_id": transactionId,
      "number_in_period": numberInPeriod,
      "period_id": periodId
    };
    const days = 12;

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
        final transactionType = TransactionType(id: id, name: name);

        when(db.get(tableName, id)).thenAnswer((_) async => <dynamic, dynamic>{
              "id": id,
              "name": name,
            });

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
        final map = {
          "id": id,
          "transaction_type_id": transactionTypeId,
          "source_id": sourceId,
          "name": name,
          "explanation": explanation,
          "amount": amount,
          "date": date.microsecondsSinceEpoch,
        };

        when(db.getAll(tableName)).thenAnswer((_) async => [map, map, map]);

        final result = await repository.getTransactions();
        expect(result.length, 3);
        expect(result[0].id, id);
        expect(result[0].transactionTypeId, transactionTypeId);
        expect(result[0].sourceId, sourceId);
        expect(result[0].name, name);
        expect(result[0].explanation, explanation);
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

        when(db.get(tableName, id)).thenAnswer((_) async => <dynamic, dynamic>{
              "id": id,
              "transaction_type_id": transactionTypeId,
              "source_id": sourceId,
              "name": name,
              "explanation": explanation,
              "amount": amount,
              "date": date.microsecondsSinceEpoch,
            });

        final result = await repository.getTransaction(id);

        expect(result.id, id);
        expect(result.transactionTypeId, transactionTypeId);
        expect(result.sourceId, sourceId);
        expect(result.name, name);
        expect(result.explanation, explanation);
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
        final map = {
          "id": id,
          "name": name,
        };

        when(db.getAll(tableName)).thenAnswer((_) async => [map, map, map]);

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
        final map = {"id": id, "name": name, "days": days};

        when(db.getAll(tableName)).thenAnswer((_) async => [map, map, map]);

        final result = await repository.getPeriods();
        expect(result.length, 3);
        expect(result[0].id, id);
        expect(result[0].name, name);
        expect(result[0].days, days);
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

        when(db.get(tableName, id)).thenAnswer((_) async =>
            <dynamic, dynamic>{"id": id, "name": name, "days": days});

        final result = await repository.getPeriod(id);

        expect(result.id, id);
        expect(result.name, name);
        expect(result.days, days);
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

        when(db.get(tableName, id)).thenAnswer((_) async => <dynamic, dynamic>{
              "id": id,
              "transaction_id": transactionId,
              "number_in_period": numberInPeriod,
              "period_id": periodId
            });

        final result = await repository.getRecurringTransaction(id);

        expect(result.id, id);
        expect(result.transactionId, transactionId);
        expect(result.numberInPeriod, numberInPeriod);
        expect(result.periodId, periodId);
      });
    });

    group("addTransaction function", () {
      const tableName = "transactions";

      test('throw error if insertion failed', () async {
        final db = MockSqliteDB();
        final errorTranslator = DomainErrorTranslator();
        final repository = TransactionRepositorySQLite(
            db: db, errorTranslator: errorTranslator);
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            explanation: explanation,
            amount: amount);

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
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            explanation: explanation,
            amount: amount);
        final map = <dynamic, dynamic>{
          "id": id,
          "transaction_type_id": transactionTypeId,
          "source_id": sourceId,
          "name": name,
          "explanation": explanation,
          "amount": amount,
          "date": date.microsecondsSinceEpoch,
        };

        when(db.insert(tableName, mapAddTransaction))
            .thenAnswer((_) async => id);
        when(db.get(tableName, id)).thenAnswer((_) async => map);

        var result = await repository.addTransaction(mapAddTransaction);
        expect(result.id, id);
        expect(result.transactionTypeId, transactionTypeId);
        expect(result.sourceId, sourceId);
        expect(result.name, name);
        expect(result.explanation, explanation);
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
        final addRecurringTransaction = AddRecurringTransaction(
            transactionId: transactionId,
            numberInPeriod: numberInPeriod,
            periodId: periodId);

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
        final addRecurringTransaction = AddRecurringTransaction(
            transactionId: transactionId,
            numberInPeriod: numberInPeriod,
            periodId: periodId);
        final map = <dynamic, dynamic>{
          "id": id,
          "transaction_id": transactionId,
          "number_in_period": numberInPeriod,
          "period_id": periodId
        };

        when(db.insert(tableName, mapAddRecurringTransaction))
            .thenAnswer((_) async => id);
        when(db.get(tableName, id)).thenAnswer((_) async => map);

        var result = await repository
            .addRecurringTransaction(mapAddRecurringTransaction);
        expect(result.id, id);
        expect(result.transactionId, transactionId);
        expect(result.numberInPeriod, numberInPeriod);
        expect(result.periodId, periodId);
      });
    });
  });
}
