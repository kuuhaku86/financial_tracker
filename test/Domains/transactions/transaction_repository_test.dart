import 'package:financial_tracker/Domains/transactions/entities/add_recurring_transaction.dart';
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

    test('getTransactions throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.getTransactions(), throwsException);
    });

    test('getTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.getTransaction(1), throwsException);
    });

    test('getTransactionTypes throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository.getTransactionTypes(), throwsException);
    });

    test('getPeriods throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.getPeriods(), throwsException);
    });

    test('getPeriod throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.getPeriod(1), throwsException);
    });

    test('getRecurringTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.getRecurringTransaction(1),
          throwsException);
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

    test('addRecurringTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository
                  .addRecurringTransaction(AddRecurringTransaction(
                transactionId: 1,
                periodId: 1,
                numberInPeriod: 1,
              )),
          throwsException);
    });
  });
}
