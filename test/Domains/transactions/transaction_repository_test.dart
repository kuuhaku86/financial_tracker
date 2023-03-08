import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';
import 'package:test/test.dart';

void main() {
  group("TransactionRepository interface", () {
    test('getTransactionType throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository.getTransactionType(1), throwsException);
    });

    test('addTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository.addTransaction(AddTransaction(
              transactionTypeId: 1,
              sourceId: 1,
              name: "test",
              explanation: "test_explanation",
              amount: 1)),
          throwsException);
    });
  });
}
