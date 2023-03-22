import 'package:financial_tracker/Applications/usecase/get_recurring_transaction_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetRecurringTransactionUsecase class", () {
    const id = 345;
    const transactionId = 123;
    const numberInPeriod = 234;
    const periodId = 456;

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final recurringTransaction = RecurringTransaction(
          id: id,
          transactionId: transactionId,
          numberInPeriod: numberInPeriod,
          periodId: periodId);

      when(transactionRepository.getRecurringTransaction(id))
          .thenAnswer((_) async => recurringTransaction); // 4211000

      final getRecurringTransactionUsecase = GetRecurringTransactionUsecase(
          transactionRepository: transactionRepository);

      final result = await getRecurringTransactionUsecase.execute(
          recurringTransactionId: id);

      expect(result.id, recurringTransaction.id);
      expect(result.transactionId, recurringTransaction.transactionId);
      expect(result.numberInPeriod, recurringTransaction.numberInPeriod);
      expect(result.periodId, recurringTransaction.periodId);
    });

    test(
        'execution failed because no recurring transaction with id existed yet',
        () {
      final transactionRepository = MockTransactionRepository();
      final errorTranslator = DomainErrorTranslator();

      when(transactionRepository.getRecurringTransaction(id)).thenThrow(
          errorTranslator
              .translate(ExceptionEnum.recurringTransactionNotFound));

      final getRecurringTransactionUsecase = GetRecurringTransactionUsecase(
          transactionRepository: transactionRepository);

      expect(
          getRecurringTransactionUsecase.execute(recurringTransactionId: id),
          throwsA(errorTranslator
              .translate(ExceptionEnum.recurringTransactionNotFound)));
    });
  });
}
