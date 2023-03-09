import 'package:financial_tracker/Applications/usecase/add_source_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/add_source.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/source_repository.mocks.dart';

void main() {
  group("AddSourceUsecase class", () {
    const sourceId = 123;
    const name = "add_source_name_test";
    const imageRoute = "add_source_image_route_test";

    test('execution success', () async {
      final sourceRepository = MockSourceRepository();
      final addSource = AddSource(name: name, imageRoute: imageRoute);
      final source = Source(
          id: sourceId,
          name: name,
          imageRoute: imageRoute);

      when(sourceRepository.addSource(addSource)).thenAnswer((_) async => source);

      final addSourceUsecase =
          AddSourceUsecase(sourceRepository: sourceRepository);

      final result = await addSourceUsecase.execute(addSource);

      expect(result.id, source.id);
      expect(result.name, source.name);
      expect(result.imageRoute, source.imageRoute);
    });
  });
}
