import 'package:financial_tracker/Applications/usecase/delete_transaction_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("DeleteTransactionUsecase class", () {
    const id = 123;
    const transactionTypeId = 345;
    const sourceId = 456;
    const detail = "delete_transaction_detail_test";
    const amount = 123321.0;
    const recurringTransactionId = 234;
    const name = "delete_transaction_name_test";
    final date = DateTime.now();
    final recurringTransaction = RecurringTransaction(
        id: recurringTransactionId,
        transactionId: id,
        numberInPeriod: 2,
        periodId: 2);
    final transaction = Transaction(
        id: id,
        transactionTypeId: transactionTypeId,
        sourceId: sourceId,
        name: name,
        detail: detail,
        amount: amount,
        date: date);

    group('RecurringTransaction Object exist', () {
      test('execution failed for delete recurring transaction', () async {
        final transactionRepository = MockTransactionRepository();

        when(transactionRepository.getRecurringTransactionByTransactionId(id))
            .thenAnswer((_) async => recurringTransaction);
        when(transactionRepository
                .deleteRecurringTransaction(recurringTransactionId))
            .thenThrow(Exception());

        final usecase = DeleteTransactionUsecase(
            transactionRepository: transactionRepository);

        expect(usecase.execute(transaction), throwsException);
      });

      test('execution failed for delete transaction', () async {
        final transactionRepository = MockTransactionRepository();

        when(transactionRepository.getRecurringTransactionByTransactionId(id))
            .thenAnswer((_) async => recurringTransaction);
        when(transactionRepository
                .deleteRecurringTransaction(recurringTransactionId))
            .thenAnswer((_) => Future.value(null));
        when(transactionRepository.deleteTransaction(id))
            .thenThrow(Exception());

        final usecase = DeleteTransactionUsecase(
            transactionRepository: transactionRepository);

        expect(usecase.execute(transaction), throwsException);
      });

      test('execution success', () async {
        final transactionRepository = MockTransactionRepository();

        when(transactionRepository.getRecurringTransactionByTransactionId(id))
            .thenAnswer((_) async => recurringTransaction);
        when(transactionRepository
                .deleteRecurringTransaction(recurringTransactionId))
            .thenAnswer((_) async {});
        when(transactionRepository.deleteTransaction(id))
            .thenAnswer((_) async {});

        final usecase = DeleteTransactionUsecase(
            transactionRepository: transactionRepository);

        await usecase.execute(transaction);

        verify(transactionRepository.getRecurringTransactionByTransactionId(id))
            .called(1);
        verify(transactionRepository
                .deleteRecurringTransaction(recurringTransaction.id))
            .called(1);
        verify(transactionRepository.deleteTransaction(id)).called(1);
      });
    });

    group('RecurringTransaction Object doesn\'t exist', () {
      test('execution failed for delete transaction', () async {
        final transactionRepository = MockTransactionRepository();

        when(transactionRepository.getRecurringTransactionByTransactionId(id))
            .thenThrow(Exception());
        when(transactionRepository.deleteTransaction(id))
            .thenThrow(Exception());

        final usecase = DeleteTransactionUsecase(
            transactionRepository: transactionRepository);

        expect(usecase.execute(transaction), throwsException);
      });

      test('execution success', () async {
        final transactionRepository = MockTransactionRepository();

        when(transactionRepository.getRecurringTransactionByTransactionId(id))
            .thenThrow(Exception());
        when(transactionRepository.deleteTransaction(id))
            .thenAnswer((_) => Future.value(null));

        final usecase = DeleteTransactionUsecase(
            transactionRepository: transactionRepository);

        await usecase.execute(transaction);
        verify(transactionRepository.getRecurringTransactionByTransactionId(id))
            .called(1);
        verifyNever(transactionRepository
            .deleteRecurringTransaction(recurringTransactionId));
        verify(transactionRepository.deleteTransaction(id)).called(1);
      });
    });
  });
}
