import 'dart:io';

import 'package:financial_tracker/Applications/usecase/add_source_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/file_manager.mocks.dart';
import '../../mocks/source_repository.mocks.dart';

void main() {
  group("AddSourceUsecase class", () {
    const sourceId = 123;
    const name = "add_source_name_test";
    const imageRoute = "add_source_image_route_test";
    final addSource = AddSource(name: name, image: File(imageRoute));

    test('execution success', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();
      final source = Source(id: sourceId, name: name, imageRoute: imageRoute);

      when(fileManager.addFile(addSource.image))
          .thenAnswer((_) async => imageRoute);
      when(sourceRepository.addSource(
              <String, Object>{"name": name, "image_route": imageRoute}))
          .thenAnswer((_) async => source);

      final addSourceUsecase = AddSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      final result = await addSourceUsecase.execute(addSource);

      expect(result.id, source.id);
      expect(result.name, source.name);
      expect(result.imageRoute, source.imageRoute);
    });

    test('execution failed for add file', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();
      final errorTranslator = DomainErrorTranslator();

      when(fileManager.addFile(addSource.image)).thenThrow(Exception());

      final addSourceUsecase = AddSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(addSourceUsecase.execute(addSource), throwsException);
    });

    test('execution failed for add source', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();
      final errorTranslator = DomainErrorTranslator();

      when(fileManager.addFile(addSource.image))
          .thenAnswer((_) async => imageRoute);
      when(sourceRepository.addSource(
              <String, Object>{"name": name, "image_route": imageRoute}))
          .thenThrow(errorTranslator.translate(ExceptionEnum.addSourceFailed));

      final addSourceUsecase = AddSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(addSourceUsecase.execute(addSource),
          throwsA(errorTranslator.translate(ExceptionEnum.addSourceFailed)));
    });
  });
}
