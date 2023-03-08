
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:test/test.dart';

void main() {
  group("Period class", () {
    test('object creation success', () {
      const name = "period_name_test";
      const id = 123;
      final period = Period(
        id: id,
        name: name,
      );

      expect(period.id, id);
      expect(period.name, name);
    });

    test('object creation from map success', () {
      const name = "period_name_test";
      const id = 123;
      Map<String, Object> map = {
        "id": id,
        "name": name,
      };
      final period = Period.fromMap(map);

      expect(period.id, id);
      expect(period.name, name);
    });
  });
}
