// Import the test package and Counter class
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
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

      expect(() => sourceRepository.addSource(<String, Object>{}),
          throwsException);
    });

    test('deleteSource throws exception', () {
      final sourceRepository = SourceRepository();

      expect(() => sourceRepository.deleteSource(1), throwsException);
    });

    test('updateSource throws exception', () {
      final sourceRepository = SourceRepository();
      final source =
          Source(id: 1, name: "test", imageRoute: "test_image_route");

      expect(() => sourceRepository.updateSource(source), throwsException);
    });
  });
}
