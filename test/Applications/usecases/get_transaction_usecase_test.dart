import 'package:financial_tracker/Applications/usecase/get_transaction_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetTransactionUsecase class", () {
    const id = 345;
    const sourceId = 123;
    const transactionTypeId = 234;
    const name = "add_transaction_name_test";
    const explanation = "add_transaction_explanation_test";
    const amount = 12000.0;
    final date = DateTime.now();

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final transaction = Transaction(
          id: id,
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          explanation: explanation,
          amount: amount,
          date: date);

      when(transactionRepository.getTransaction(id))
          .thenAnswer((_) async => transaction);

      final getTransactionUsecase =
          GetTransactionUsecase(transactionRepository: transactionRepository);

      final result = await getTransactionUsecase.execute(transactionId: id);

      expect(result.id, transaction.id);
      expect(result.transactionTypeId, transaction.transactionTypeId);
      expect(result.sourceId, transaction.sourceId);
      expect(result.name, transaction.name);
      expect(result.explanation, transaction.explanation);
      expect(result.amount, transaction.amount);
      expect(result.date, transaction.date);
    });

    test('execution failed because no transaction with id existed yet', () {
      final transactionRepository = MockTransactionRepository();
      final errorTranslator = DomainErrorTranslator();

      when(transactionRepository.getTransaction(id))
          .thenThrow(errorTranslator.translate(ExceptionEnum.transactionNotFound));

      final getTransactionUsecase =
          GetTransactionUsecase(transactionRepository: transactionRepository);

      expect(getTransactionUsecase.execute(transactionId: id), throwsA(errorTranslator.translate(ExceptionEnum.transactionNotFound)));
    });
  });
}