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

    test('getRecurringTransactionByTransactionId throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository.getRecurringTransactionByTransactionId(1),
          throwsException);
    });

    test('getTransactionsBySourceId throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.getTransactionsBySourceId(1),
          throwsException);
    });

    test('addTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository.addTransaction(<String, Object>{
                "transaction_type_id": 1,
                "source_id": 1,
                "name": "test",
                "detail": "test_detail",
                "amount": 1
              }),
          throwsException);
    });

    test('addRecurringTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(
          () => transactionRepository.addRecurringTransaction(<String, Object>{
                "transaction_id": 1,
                "period_id": 1,
                "number_in_period": 1
              }),
          throwsException);
    });

    test('deleteRecurringTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.deleteRecurringTransaction(1),
          throwsException);
    });

    test('deleteTransaction throws exception', () {
      final transactionRepository = TransactionRepository();

      expect(() => transactionRepository.deleteTransaction(1), throwsException);
    });
  });
}
