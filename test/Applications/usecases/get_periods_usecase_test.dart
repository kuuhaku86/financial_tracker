import 'package:financial_tracker/Applications/usecase/get_periods_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetPeriodsUsecase class", () {
    const id = 345;
    const name = "get_periods_name_test";
    const days = 12;

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final period = Period(id: id, name: name, days: days);

      when(transactionRepository.getPeriods())
          .thenAnswer((_) async => [period, period, period]);

      final getPeriodsUsecase =
          GetPeriodsUsecase(transactionRepository: transactionRepository);

      final result = await getPeriodsUsecase.execute();

      expect(result.length, 3);
      expect(result[0].id, period.id);
      expect(result[0].name, period.name);
    });
  });
}
