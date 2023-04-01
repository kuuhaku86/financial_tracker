import 'package:financial_tracker/Applications/usecase/add_transaction_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/source_repository.mocks.dart';
import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("AddTransactionUsecase class", () {
    const id = 345;
    const sourceId = 123;
    const transactionTypeId = 234;
    const name = "add_transaction_name_test";
    const detail = "add_transaction_detail_test";
    const imageRoute = "add_transaction_image_route";
    const amount = 12000.0;
    const recurringTransactionId = 456;
    const numberInPeriod = 567;
    const periodId = 678;
    final date = DateTime.now();
    final mapAddTransaction = <String, Object>{
      "transaction_type_id": transactionTypeId,
      "source_id": sourceId,
      "name": name,
      "detail": detail,
      "amount": amount
    };

    test('source not found', () async {
      final transactionRepository = MockTransactionRepository();
      final sourceRepository = MockSourceRepository();
      final errorTranslator = DomainErrorTranslator();
      final addTransaction = AddTransaction(
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          detail: detail,
          amount: amount);

      when(sourceRepository.getSource(sourceId))
          .thenThrow(errorTranslator.translate(ExceptionEnum.sourceNotFound));

      final addTransactionUsecase = AddTransactionUsecase(
          transactionRepository: transactionRepository,
          sourceRepository: sourceRepository);

      expect(addTransactionUsecase.execute(addTransaction),
          throwsA(errorTranslator.translate(ExceptionEnum.sourceNotFound)));
    });

    test('transaction type not found', () async {
      final transactionRepository = MockTransactionRepository();
      final sourceRepository = MockSourceRepository();
      final errorTranslator = DomainErrorTranslator();
      final source = Source(id: sourceId, name: name, imageRoute: imageRoute);
      final addTransaction = AddTransaction(
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          detail: detail,
          amount: amount);

      when(sourceRepository.getSource(sourceId))
          .thenAnswer((_) async => source);
      when(transactionRepository.getTransactionType(transactionTypeId))
          .thenThrow(
              errorTranslator.translate(ExceptionEnum.transactionTypeNotFound));

      final addTransactionUsecase = AddTransactionUsecase(
          transactionRepository: transactionRepository,
          sourceRepository: sourceRepository);

      expect(
          addTransactionUsecase.execute(addTransaction),
          throwsA(errorTranslator
              .translate(ExceptionEnum.transactionTypeNotFound)));
    });

    group("non-recurring", () {
      test('transaction creation failed', () async {
        final transactionRepository = MockTransactionRepository();
        final sourceRepository = MockSourceRepository();
        final errorTranslator = DomainErrorTranslator();
        final source = Source(id: sourceId, name: name, imageRoute: imageRoute);
        final transactionType =
            TransactionType(id: transactionTypeId, name: name);
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount);

        when(sourceRepository.getSource(sourceId))
            .thenAnswer((_) async => source);
        when(transactionRepository.getTransactionType(transactionTypeId))
            .thenAnswer((_) async => transactionType);
        when(transactionRepository.addTransaction(mapAddTransaction)).thenThrow(
            errorTranslator.translate(ExceptionEnum.addTransactionFailed));

        final addTransactionUsecase = AddTransactionUsecase(
            transactionRepository: transactionRepository,
            sourceRepository: sourceRepository);

        expect(
            addTransactionUsecase.execute(addTransaction),
            throwsA(
                errorTranslator.translate(ExceptionEnum.addTransactionFailed)));
      });

      test('execution success for non-recurrent transaction', () async {
        final transactionRepository = MockTransactionRepository();
        final sourceRepository = MockSourceRepository();
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount);
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final transactionType =
            TransactionType(id: transactionTypeId, name: name);
        final transaction = Transaction(
            id: id,
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            date: date);

        when(sourceRepository.getSource(sourceId))
            .thenAnswer((_) async => source);
        when(transactionRepository.getTransactionType(transactionTypeId))
            .thenAnswer((_) async => transactionType);
        when(transactionRepository.addTransaction(mapAddTransaction))
            .thenAnswer((_) async => transaction);

        final addTransactionUsecase = AddTransactionUsecase(
            transactionRepository: transactionRepository,
            sourceRepository: sourceRepository);

        final result = await addTransactionUsecase.execute(addTransaction);

        expect(result.id, transaction.id);
        expect(result.transactionTypeId, transaction.transactionTypeId);
        expect(result.sourceId, transaction.sourceId);
        expect(result.name, transaction.name);
        expect(result.detail, transaction.detail);
        expect(result.amount, transaction.amount);
        expect(result.date, transaction.date);
      });
    });

    group("recurring", () {
      test('transaction creation failed', () async {
        final transactionRepository = MockTransactionRepository();
        final sourceRepository = MockSourceRepository();
        final errorTranslator = DomainErrorTranslator();
        final source = Source(id: sourceId, name: name, imageRoute: imageRoute);
        final transactionType =
            TransactionType(id: transactionTypeId, name: name);
        final period = Period(id: periodId, name: name);
        final addTransaction = AddTransaction(
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          detail: detail,
          amount: amount,
          isRecurring: true,
          period: period,
        );

        when(sourceRepository.getSource(sourceId))
            .thenAnswer((_) async => source);
        when(transactionRepository.getTransactionType(transactionTypeId))
            .thenAnswer((_) async => transactionType);
        when(transactionRepository.getPeriod(periodId))
            .thenThrow(errorTranslator.translate(ExceptionEnum.periodNotFound));

        final addTransactionUsecase = AddTransactionUsecase(
            transactionRepository: transactionRepository,
            sourceRepository: sourceRepository);

        expect(addTransactionUsecase.execute(addTransaction),
            throwsA(errorTranslator.translate(ExceptionEnum.periodNotFound)));
      });

      test('transaction creation failed', () async {
        final transactionRepository = MockTransactionRepository();
        final sourceRepository = MockSourceRepository();
        final errorTranslator = DomainErrorTranslator();
        final source = Source(id: sourceId, name: name, imageRoute: imageRoute);
        final transactionType =
            TransactionType(id: transactionTypeId, name: name);
        final period = Period(id: periodId, name: name);
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: true,
            period: period);

        when(sourceRepository.getSource(sourceId))
            .thenAnswer((_) async => source);
        when(transactionRepository.getTransactionType(transactionTypeId))
            .thenAnswer((_) async => transactionType);
        when(transactionRepository.getPeriod(periodId))
            .thenAnswer((_) async => period);
        when(transactionRepository.addTransaction(mapAddTransaction)).thenThrow(
            errorTranslator.translate(ExceptionEnum.addTransactionFailed));

        final addTransactionUsecase = AddTransactionUsecase(
            transactionRepository: transactionRepository,
            sourceRepository: sourceRepository);

        expect(
            addTransactionUsecase.execute(addTransaction),
            throwsA(
                errorTranslator.translate(ExceptionEnum.addTransactionFailed)));
      });

      test('recurring transaction creation failed', () async {
        final transactionRepository = MockTransactionRepository();
        final sourceRepository = MockSourceRepository();
        final errorTranslator = DomainErrorTranslator();
        final source = Source(id: sourceId, name: name, imageRoute: imageRoute);
        final transactionType =
            TransactionType(id: transactionTypeId, name: name);
        final period = Period(id: periodId, name: name);
        final transaction = Transaction(
            id: id,
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            date: date);
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: true,
            period: period,
            numberInPeriod: numberInPeriod);

        when(sourceRepository.getSource(sourceId))
            .thenAnswer((_) async => source);
        when(transactionRepository.getTransactionType(transactionTypeId))
            .thenAnswer((_) async => transactionType);
        when(transactionRepository.getPeriod(periodId))
            .thenAnswer((_) async => period);
        when(transactionRepository.addTransaction(mapAddTransaction))
            .thenAnswer((_) async => transaction);
        when(transactionRepository.addRecurringTransaction(any)).thenThrow(
            errorTranslator
                .translate(ExceptionEnum.addRecurringTransactionFailed));

        final addTransactionUsecase = AddTransactionUsecase(
            transactionRepository: transactionRepository,
            sourceRepository: sourceRepository);

        expect(
            addTransactionUsecase.execute(addTransaction),
            throwsA(errorTranslator
                .translate(ExceptionEnum.addRecurringTransactionFailed)));
      });

      test('execution success for recurring transaction', () async {
        final transactionRepository = MockTransactionRepository();
        final sourceRepository = MockSourceRepository();
        final period = Period(id: periodId, name: name);
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final transactionType =
            TransactionType(id: transactionTypeId, name: name);
        final transaction = Transaction(
            id: id,
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            date: date);
        final recurringTransaction = RecurringTransaction(
            id: recurringTransactionId,
            transactionId: id,
            numberInPeriod: numberInPeriod,
            periodId: periodId);
        final addTransaction = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: true,
            numberInPeriod: numberInPeriod,
            period: period);

        when(sourceRepository.getSource(sourceId))
            .thenAnswer((_) async => source);
        when(transactionRepository.getTransactionType(transactionTypeId))
            .thenAnswer((_) async => transactionType);
        when(transactionRepository.getPeriod(periodId))
            .thenAnswer((_) async => period);
        when(transactionRepository.addTransaction(mapAddTransaction))
            .thenAnswer((_) async => transaction);
        when(transactionRepository.addRecurringTransaction(any))
            .thenAnswer((_) async => recurringTransaction);

        final addTransactionUsecase = AddTransactionUsecase(
            transactionRepository: transactionRepository,
            sourceRepository: sourceRepository);

        final result = await addTransactionUsecase.execute(addTransaction);

        expect(result.id, transaction.id);
        expect(result.transactionTypeId, transaction.transactionTypeId);
        expect(result.sourceId, transaction.sourceId);
        expect(result.name, transaction.name);
        expect(result.detail, transaction.detail);
        expect(result.amount, transaction.amount);
        expect(result.date, transaction.date);
      });
    });
  });
}
