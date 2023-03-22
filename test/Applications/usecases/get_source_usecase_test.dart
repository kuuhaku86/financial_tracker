import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/source_repository.mocks.dart';

void main() {
  group("GetSourceUsecase class", () {
    const sourceId = 123;

    test('execution success', () async {
      final sourceRepository = MockSourceRepository();
      final source = Source(
          id: sourceId,
          name: "source_name_test",
          imageRoute: "source_image_route_test");

      when(sourceRepository.getSource(sourceId))
          .thenAnswer((_) async => source);

      final getSourceUsecase =
          GetSourceUsecase(sourceRepository: sourceRepository);

      final result = await getSourceUsecase.execute(sourceId);

      expect(result.id, source.id);
      expect(result.name, source.name);
      expect(result.imageRoute, source.imageRoute);
    });

    test('execution failed because no source with id existed yet', () {
      final sourceRepository = MockSourceRepository();
      final errorTranslator = DomainErrorTranslator();

      when(sourceRepository.getSource(sourceId))
          .thenThrow(errorTranslator.translate(ExceptionEnum.sourceNotFound));

      final getSourceUsecase =
          GetSourceUsecase(sourceRepository: sourceRepository);

      expect(getSourceUsecase.execute(sourceId),
          throwsA(errorTranslator.translate(ExceptionEnum.sourceNotFound)));
    });
  });
}
