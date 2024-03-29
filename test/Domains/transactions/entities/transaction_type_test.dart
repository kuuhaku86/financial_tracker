import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:test/test.dart';

void main() {
  group("TransactionType class", () {
    const id = 123;
    const name = "transaction_type_name_test";

    test('object creation success', () {
      final transactionType = TransactionType(id: id, name: name);

      expect(transactionType.id, id);
      expect(transactionType.name, name);
    });

    test('object creation from map success', () {
      Map<dynamic, dynamic> map = {
        "id": id,
        "name": name,
      };
      final transactionType = TransactionType.fromMap(map);

      expect(transactionType.id, id);
      expect(transactionType.name, name);
    });
  });
}
