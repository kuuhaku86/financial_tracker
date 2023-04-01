import 'package:financial_tracker/Applications/usecase/get_transaction_types_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetPeriodsUsecase class", () {
    const id = 345;
    const name = "get_transaction_types_name_test";

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final transactionType = TransactionType(id: id, name: name);

      when(transactionRepository.getTransactionTypes()).thenAnswer(
          (_) async => [transactionType, transactionType, transactionType]);

      final getTransactionTypesUsecase = GetTransactionTypesUsecase(
          transactionRepository: transactionRepository);

      final result = await getTransactionTypesUsecase.execute();

      expect(result.length, 3);
      expect(result[0].id, transactionType.id);
      expect(result[0].name, transactionType.name);
    });
  });
}
