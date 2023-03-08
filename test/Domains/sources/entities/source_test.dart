import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:test/test.dart';

void main() {
  group("Source class", () {
    test('object creation success', () {
      const name = "source_name_test";
      const imageRoute = "source_image_route_test";
      const id = 123;
      final source = Source(
        id: id,
        name: name,
        imageRoute: imageRoute,
      );

      expect(source.id, id);
      expect(source.name, name);
      expect(source.imageRoute, imageRoute);
    });

    test('object creation from map success', () {
      const name = "source_name_test";
      const imageRoute = "source_image_route_test";
      const id = 123;
      Map<String, Object> map = {
        "id": id,
        "name": name,
        "image_route": imageRoute,
      };
      final source = Source.fromMap(map);

      expect(source.id, id);
      expect(source.name, name);
      expect(source.imageRoute, imageRoute);
    });
  });
}
