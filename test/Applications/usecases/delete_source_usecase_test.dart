import 'dart:math';

import 'package:financial_tracker/Applications/usecase/delete_source_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/file_manager.mocks.dart';
import '../../mocks/source_repository.mocks.dart';

void main() {
  group("DeleteSourceUsecase class", () {
    const id = 123;
    const name = "delete_source_name_test";
    const imageRoute = "delete_source_image_route_test";
    final source = Source(id: id, name: name, imageRoute: imageRoute);

    test('execution success', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();

      when(fileManager.deleteFile(imageRoute))
          .thenAnswer((_) => Future.value(null));
      when(sourceRepository.deleteSource(id))
          .thenAnswer((_) => Future.value(null));

      final usecase = DeleteSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(usecase.execute(source), isA<Future<void>>());
    });

    test('execution failed for delete file', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();

      when(fileManager.deleteFile(imageRoute)).thenThrow(Exception());

      final usecase = DeleteSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(usecase.execute(source), throwsException);
    });

    test('execution failed for add source', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();

      when(fileManager.deleteFile(imageRoute))
          .thenAnswer((_) => Future.value(null));
      when(sourceRepository.deleteSource(id)).thenThrow(Exception());

      final usecase = DeleteSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(usecase.execute(source), throwsException);
    });
  });
}
