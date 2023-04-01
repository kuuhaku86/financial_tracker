import 'package:financial_tracker/Applications/usecase/get_recurring_transaction_by_transaction_id_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetRecurringTransactionByTransactionIdUsecase class", () {
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

      when(transactionRepository.getRecurringTransactionByTransactionId(id))
          .thenAnswer((_) async => recurringTransaction); // 4211000

      final usecase = GetRecurringTransactionByTransactionIdUsecase(
          transactionRepository: transactionRepository);

      final result = await usecase.execute(id);

      expect(result.id, recurringTransaction.id);
      expect(result.transactionId, recurringTransaction.transactionId);
      expect(result.numberInPeriod, recurringTransaction.numberInPeriod);
      expect(result.periodId, recurringTransaction.periodId);
    });

    test(
        'execution failed because no recurring transaction with transaction id existed yet',
        () {
      final transactionRepository = MockTransactionRepository();
      final errorTranslator = DomainErrorTranslator();

      when(transactionRepository.getRecurringTransactionByTransactionId(id))
          .thenThrow(errorTranslator
              .translate(ExceptionEnum.recurringTransactionNotFound));

      final usecase = GetRecurringTransactionByTransactionIdUsecase(
          transactionRepository: transactionRepository);

      expect(
          usecase.execute(id),
          throwsA(errorTranslator
              .translate(ExceptionEnum.recurringTransactionNotFound)));
    });
  });
}
