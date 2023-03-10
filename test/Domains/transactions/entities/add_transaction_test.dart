import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:test/test.dart';

void main() {
  group("AddTransaction class", () {
    const transactionTypeId = 123;
    const sourceId = 321;
    const name = "add_transaction_name_test";
    const explanation = "add_transaction_explanation_test";
    const amount = 123123.0;
    const isRecurrent = true;
    const numberInPeriod = 3;

    test('object creation success', () {
      Period period = Period(id: 12, name: "add_transaction_period_test");
      final addTransaction = AddTransaction(
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          explanation: explanation,
          amount: amount,
          isRecurring: isRecurrent,
          numberInPeriod: numberInPeriod,
          period: period);

      expect(addTransaction.transactionTypeId, transactionTypeId);
      expect(addTransaction.sourceId, sourceId);
      expect(addTransaction.name, name);
      expect(addTransaction.explanation, explanation);
      expect(addTransaction.amount, amount);
      expect(addTransaction.isRecurring, isRecurrent);
      expect(addTransaction.numberInPeriod, numberInPeriod);
      expect(addTransaction.period, period);
    });
  });
}
