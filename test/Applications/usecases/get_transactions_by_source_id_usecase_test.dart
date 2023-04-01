import 'package:financial_tracker/Applications/usecase/get_transactions_by_source_id_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetTransactionsBySourceIdUsecase class", () {
    const id = 345;
    const sourceId = 123;
    const transactionTypeId = 234;
    const name = "add_transaction_name_test";
    const detail = "add_transaction_detail_test";
    const amount = 12000.0;
    final date = DateTime.now();

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final transaction = Transaction(
          id: id,
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          detail: detail,
          amount: amount,
          date: date);

      when(transactionRepository.getTransactionsBySourceId(sourceId))
          .thenAnswer((_) async => [transaction, transaction, transaction]);

      final usecase = GetTransactionsBySourceIdUsecase(
          transactionRepository: transactionRepository);

      final result = await usecase.execute(sourceId);

      expect(result.length, 3);
      expect(result[0].id, transaction.id);
      expect(result[0].transactionTypeId, transaction.transactionTypeId);
      expect(result[0].sourceId, transaction.sourceId);
      expect(result[0].name, transaction.name);
      expect(result[0].detail, transaction.detail);
      expect(result[0].amount, transaction.amount);
      expect(result[0].date, transaction.date);
    });
  });
}
