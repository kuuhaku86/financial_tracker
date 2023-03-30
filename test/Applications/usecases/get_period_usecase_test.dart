import 'package:financial_tracker/Applications/usecase/get_period_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetPeriodUsecase class", () {
    const id = 345;
    const name = "get_period_name_test";

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final period = Period(id: id, name: name);

      when(transactionRepository.getPeriod(id)).thenAnswer((_) async => period);

      final getPeriodUsecase =
          GetPeriodUsecase(transactionRepository: transactionRepository);

      final result = await getPeriodUsecase.execute(periodId: id);

      expect(result.id, period.id);
      expect(result.name, period.name);
    });

    test('execution failed because no period with id existed yet', () {
      final transactionRepository = MockTransactionRepository();
      final errorTranslator = DomainErrorTranslator();

      when(transactionRepository.getPeriod(id))
          .thenThrow(errorTranslator.translate(ExceptionEnum.periodNotFound));

      final getPeriodUsecase =
          GetPeriodUsecase(transactionRepository: transactionRepository);

      expect(getPeriodUsecase.execute(periodId: id),
          throwsA(errorTranslator.translate(ExceptionEnum.periodNotFound)));
    });
  });
}
