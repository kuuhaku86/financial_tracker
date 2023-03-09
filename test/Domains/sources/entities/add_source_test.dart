import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:test/test.dart';

void main() {
  group("AddSource class", () {
    const name = "add_source_name_test";
    const imageRoute = "add_source_image_route_test";

    test('object creation success', () {
      final addSource = AddSource(name: name, imageRoute: imageRoute);
      expect(addSource.name, name);
      expect(addSource.imageRoute, imageRoute);
    });
  });
}
