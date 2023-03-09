import 'package:financial_tracker/Applications/usecase/add_transaction_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
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
    const explanation = "add_transaction_explanation_test";
    const imageRoute = "add_transaction_image_route";
    const amount = 12000.0;
    final date = DateTime.now();

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final sourceRepository = MockSourceRepository();
      final addTransaction = AddTransaction(
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          explanation: explanation,
          amount: amount);
      final source = Source(id: id, name: name, imageRoute: imageRoute);
      final transactionType = TransactionType(id: transactionTypeId, name: name);
      final transaction = Transaction(
          id: id,
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          explanation: explanation,
          amount: amount,
          date: date);

      when(sourceRepository.getSource(sourceId))
          .thenAnswer((_) async => source);
      when(transactionRepository.getTransactionType(transactionTypeId))
          .thenAnswer((_) async => transactionType);
      when(transactionRepository.addTransaction(addTransaction))
          .thenAnswer((_) async => transaction);

      final addTransactionUsecase = AddTransactionUsecase(
          transactionRepository: transactionRepository,
          sourceRepository: sourceRepository);

      final result = await addTransactionUsecase.execute(addTransaction);

      expect(result.id, transaction.id);
      expect(result.transactionTypeId, transaction.transactionTypeId);
      expect(result.sourceId, transaction.sourceId);
      expect(result.name, transaction.name);
      expect(result.explanation, transaction.explanation);
      expect(result.amount, transaction.amount);
      expect(result.date, transaction.date);
    });
  });
}
