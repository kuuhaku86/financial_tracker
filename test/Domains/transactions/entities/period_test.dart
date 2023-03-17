import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:test/test.dart';

void main() {
  group("Period class", () {
    const name = "period_name_test";
    const id = 123;
    const days = 12;

    test('object creation success', () {
      final period = Period(id: id, name: name, days: days);

      expect(period.id, id);
      expect(period.name, name);
      expect(period.days, days);
    });

    test('object creation from map success', () {
      Map<dynamic, dynamic> map = {"id": id, "name": name, "days": days};
      final period = Period.fromMap(map);

      expect(period.id, id);
      expect(period.name, name);
      expect(period.days, days);
    });
  });
}
