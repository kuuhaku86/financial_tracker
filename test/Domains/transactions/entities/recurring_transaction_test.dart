import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:test/test.dart';

void main() {
  group("RecurringTransaction class", () {
    test('object creation success', () {
      const id = 123;
      const transactionId = 321;
      const numberInPeriod = 121;
      const periodId = 234;
      final recurringTransaction = RecurringTransaction(
          id: id,
          transactionId: transactionId,
          numberInPeriod: numberInPeriod,
          periodId: periodId);

      expect(recurringTransaction.id, id);
      expect(recurringTransaction.transactionId, transactionId);
      expect(recurringTransaction.numberInPeriod, numberInPeriod);
      expect(recurringTransaction.periodId, periodId);
    });

    test('object creation from map success', () {
      const id = 123;
      const transactionId = 321;
      const numberInPeriod = 121;
      const periodId = 234;
      Map<String, Object> map = {
        "id": id,
        "transaction_id": transactionId,
        "number_in_period": numberInPeriod,
        "period_id": periodId,
      };
      final recurringTransaction = RecurringTransaction.fromMap(map);

      expect(recurringTransaction.id, id);
      expect(recurringTransaction.transactionId, transactionId);
      expect(recurringTransaction.numberInPeriod, numberInPeriod);
      expect(recurringTransaction.periodId, periodId);
    });
  });
}
