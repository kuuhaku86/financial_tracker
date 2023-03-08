// Import the test package and Counter class
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:test/test.dart';

void main() {
  group("SourceRepository interface", () {
    test('getSource throws exception', () {
      final sourceRepository = SourceRepository();

      expect(() => sourceRepository.getSource(1), throwsException);
    });

    test('getSource throws exception', () {
      final sourceRepository = SourceRepository();

      expect(
          () => sourceRepository
              .addSource(AddSource(name: "test", imageRoute: "test/test")),
          throwsException);
    });
  });
}
