import 'package:financial_tracker/Applications/usecase/update_transaction_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("UpdateTransactionUsecase class", () {
    const id = 123;
    const name = "update_transaction_name_test";
    const transactionTypeId = 234;
    const sourceId = 345;
    const detail = "update_transaction_detail_test";
    const amount = 2345.6;
    const numberInPeriod = 4;
    const periodId = 567;
    final date = DateTime.now();
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
        transactionId: id,
        numberInPeriod: numberInPeriod,
        periodId: periodId);
    final period = Period(id: periodId, name: name);
    final mapRecurringTransaction = {
      "transaction_id": id,
      "number_in_period": numberInPeriod,
      "period_id": periodId
    };

    group("RecurringTransaction not null", () {
      test('change from recurring to non-recurring transaction', () async {
        final newData = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: false);
        final transactionRepository = MockTransactionRepository();
        final usecase = UpdateTransactionsUsecase(
            transactionRepository: transactionRepository);

        when(transactionRepository.deleteRecurringTransaction(id))
            .thenAnswer((_) => Future.value(null));
        when(transactionRepository.updateTransaction(transaction))
            .thenAnswer((_) => Future.value(null));

        await usecase.execute(transaction, recurringTransaction, newData);
        verify(transactionRepository.deleteRecurringTransaction(id)).called(1);
        verifyNever(transactionRepository
            .updateRecurringTransaction(recurringTransaction));
        verifyNever(transactionRepository
            .addRecurringTransaction(mapRecurringTransaction));
        verify(transactionRepository.updateTransaction(transaction)).called(1);
      });

      test('change value of recurring transaction only', () async {
        final newData = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: true,
            numberInPeriod: numberInPeriod,
            period: period);
        final transactionRepository = MockTransactionRepository();
        final usecase = UpdateTransactionsUsecase(
            transactionRepository: transactionRepository);

        when(transactionRepository
                .updateRecurringTransaction(recurringTransaction))
            .thenAnswer((_) => Future.value(null));
        when(transactionRepository.updateTransaction(transaction))
            .thenAnswer((_) => Future.value(null));

        await usecase.execute(transaction, recurringTransaction, newData);
        verifyNever(transactionRepository.deleteRecurringTransaction(id));
        verify(transactionRepository
                .updateRecurringTransaction(recurringTransaction))
            .called(1);
        verifyNever(transactionRepository
            .addRecurringTransaction(mapRecurringTransaction));
        verify(transactionRepository.updateTransaction(transaction)).called(1);
      });
    });

    group("RecurringTransaction null", () {
      test('change from non-recurring to recurring transaction', () async {
        final newData = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: true,
            numberInPeriod: numberInPeriod,
            period: period);
        final transactionRepository = MockTransactionRepository();
        final usecase = UpdateTransactionsUsecase(
            transactionRepository: transactionRepository);

        when(transactionRepository
                .addRecurringTransaction(mapRecurringTransaction))
            .thenAnswer((_) async => recurringTransaction);
        when(transactionRepository.updateTransaction(transaction))
            .thenAnswer((_) => Future.value(null));

        await usecase.execute(transaction, null, newData);
        verifyNever(transactionRepository.deleteRecurringTransaction(id));
        verifyNever(transactionRepository
            .updateRecurringTransaction(recurringTransaction));
        verify(transactionRepository
                .addRecurringTransaction(mapRecurringTransaction))
            .called(1);
        verify(transactionRepository.updateTransaction(transaction)).called(1);
      });

      test('no changes in non-recurring transaction', () async {
        final newData = AddTransaction(
            transactionTypeId: transactionTypeId,
            sourceId: sourceId,
            name: name,
            detail: detail,
            amount: amount,
            isRecurring: false);
        final transactionRepository = MockTransactionRepository();
        final usecase = UpdateTransactionsUsecase(
            transactionRepository: transactionRepository);

        when(transactionRepository.updateTransaction(transaction))
            .thenAnswer((_) => Future.value(null));

        await usecase.execute(transaction, null, newData);
        verifyNever(transactionRepository.deleteRecurringTransaction(id));
        verifyNever(transactionRepository
                .updateRecurringTransaction(recurringTransaction));
        verifyNever(transactionRepository
            .addRecurringTransaction(mapRecurringTransaction));
        verify(transactionRepository.updateTransaction(transaction)).called(1);
      });
    });
  });
}
