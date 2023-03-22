// Import the test package and Counter class
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:test/test.dart';

void main() {
  group("SourceRepository interface", () {
    test('getSource throws exception', () {
      final sourceRepository = SourceRepository();

      expect(() => sourceRepository.getSource(1), throwsException);
    });

    test('getSources throws exception', () {
      final sourceRepository = SourceRepository();

      expect(() => sourceRepository.getSources(), throwsException);
    });

    test('addSource throws exception', () {
      final sourceRepository = SourceRepository();

      expect(
          () => sourceRepository
              .addSource(<String, Object>{}),
          throwsException);
    });
  });
}
