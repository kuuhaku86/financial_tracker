import 'package:financial_tracker/Applications/usecase/get_transactions_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetTransactionsUsecase class", () {
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

      when(transactionRepository.getTransactions())
          .thenAnswer((_) async => [transaction, transaction, transaction]);

      final getTransactionsUsecase =
          GetTransactionsUsecase(transactionRepository: transactionRepository);

      final result = await getTransactionsUsecase.execute();

      expect(result.length, 3);
      expect(result[0].id, transaction.id);
      expect(result[0].transactionTypeId, transaction.transactionTypeId);
      expect(result[0].sourceId, transaction.sourceId);
      expect(result[0].name, transaction.name);
      expect(result[0].explanation, transaction.explanation);
      expect(result[0].amount, transaction.amount);
      expect(result[0].date, transaction.date);
    });
  });
}
