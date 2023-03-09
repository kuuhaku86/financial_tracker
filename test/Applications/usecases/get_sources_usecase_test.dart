import 'package:financial_tracker/Applications/usecase/get_sources_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/source_repository.mocks.dart';

void main() {
  group("GetSourcesUsecase class", () {
    const sourceId = 123;

    test('execution success', () async {
      final sourceRepository = MockSourceRepository();
      final source = Source(
          id: sourceId,
          name: "source_name_test",
          imageRoute: "source_image_route_test");

      when(sourceRepository.getSources())
          .thenAnswer((_) async => [source, source, source]);

      final getSourcesUsecase =
          GetSourcesUsecase(sourceRepository: sourceRepository);

      final result = await getSourcesUsecase.execute();

      expect(result.length, 3);
      expect(result[0].id, source.id);
      expect(result[0].name, source.name);
      expect(result[0].imageRoute, source.imageRoute);
    });
  });
}
