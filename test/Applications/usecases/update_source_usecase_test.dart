import 'dart:io';

import 'package:financial_tracker/Applications/usecase/update_source_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/file_manager.mocks.dart';
import '../../mocks/source_repository.mocks.dart';

void main() {
  group("DeleteSourceUsecase class", () {
    const id = 123;
    const name = "update_source_name_test";
    const imageRoute = "update_source_image_route_test";

    group("Update file image needed", () {
      test('execution success', () async {
        final sourceRepository = MockSourceRepository();
        final fileManager = MockFileManager();
        const newName = "test/new_name";
        const newImageRoute = "test/new_image";
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final newData = AddSource(name: newName, image: File(newImageRoute));

        when(fileManager.addFile(newData.image))
            .thenAnswer((_) async => "test/new_image");
        when(fileManager.deleteFile(imageRoute))
            .thenAnswer((_) async => Future.value(null));
        when(sourceRepository.updateSource(
                Source(id: id, name: newName, imageRoute: newImageRoute)))
            .thenAnswer((_) async => Future.value(null));

        final usecase = UpdateSourceUsecase(
            sourceRepository: sourceRepository, fileManager: fileManager);

        expect(usecase.execute(source, newData), isA<Future<void>>());
      });

      test('add file failed', () async {
        final sourceRepository = MockSourceRepository();
        final fileManager = MockFileManager();
        const newName = "test/new_name";
        const newImageRoute = "test/new_image";
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final newData = AddSource(name: newName, image: File(newImageRoute));

        when(fileManager.addFile(newData.image)).thenThrow(Exception());

        final usecase = UpdateSourceUsecase(
            sourceRepository: sourceRepository, fileManager: fileManager);

        expect(usecase.execute(source, newData), throwsException);
      });

      test('delete file failed', () async {
        final sourceRepository = MockSourceRepository();
        final fileManager = MockFileManager();
        const newName = "test/new_name";
        const newImageRoute = "test/new_image";
        final source = Source(id: id, name: name, imageRoute: imageRoute);
        final newData = AddSource(name: newName, image: File(newImageRoute));

        when(fileManager.addFile(newData.image))
            .thenAnswer((_) async => "test/new_image");
        when(fileManager.deleteFile(imageRoute)).thenThrow(Exception());

        final usecase = UpdateSourceUsecase(
            sourceRepository: sourceRepository, fileManager: fileManager);

        expect(usecase.execute(source, newData), throwsException);
      });
    });

    test('execution success', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();
      const newName = "test/new_name";
      final source = Source(id: id, name: name, imageRoute: imageRoute);
      final newData = AddSource(name: newName, image: File(imageRoute));

      when(sourceRepository.updateSource(
              Source(id: id, name: newName, imageRoute: imageRoute)))
          .thenAnswer((_) async => Future.value(null));

      final usecase = UpdateSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(usecase.execute(source, newData), isA<Future<void>>());
    });

    test('execution failed', () async {
      final sourceRepository = MockSourceRepository();
      final fileManager = MockFileManager();
      const newName = "test/new_name";
      final source = Source(id: id, name: newName, imageRoute: imageRoute);
      final newData = AddSource(name: newName, image: File(imageRoute));

      when(sourceRepository.updateSource(source)).thenThrow(Exception());

      final usecase = UpdateSourceUsecase(
          sourceRepository: sourceRepository, fileManager: fileManager);

      expect(usecase.execute(source, newData), throwsException);
    });
  });
}
