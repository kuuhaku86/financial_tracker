import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:test/test.dart';

void main() {
  group("Transaction class", () {
    const id = 123;
    const transactionTypeId = 234;
    const sourceId = 345;
    const name = "transaction_name_test";
    const detail = "transaction_detail_test";
    const amount = 456.0;
    DateTime date = DateTime.now();

    test('object creation success', () {
      final transaction = Transaction(
          id: id,
          transactionTypeId: transactionTypeId,
          sourceId: sourceId,
          name: name,
          detail: detail,
          amount: amount,
          date: date);

      expect(transaction.id, id);
      expect(transaction.transactionTypeId, transactionTypeId);
      expect(transaction.sourceId, sourceId);
      expect(transaction.name, name);
      expect(transaction.detail, detail);
      expect(transaction.amount, amount);
      expect(transaction.date, date);
    });

    test('object creation from map success', () {
      Map<dynamic, dynamic> map = {
        "id": id,
        "transaction_type_id": transactionTypeId,
        "source_id": sourceId,
        "name": name,
        "detail": detail,
        "amount": amount,
        "date": date.microsecondsSinceEpoch,
      };
      final transaction = Transaction.fromMap(map);

      expect(transaction.id, id);
      expect(transaction.transactionTypeId, transactionTypeId);
      expect(transaction.sourceId, sourceId);
      expect(transaction.name, name);
      expect(transaction.detail, detail);
      expect(transaction.amount, amount);
      expect(transaction.date, date);
    });
  });
}
