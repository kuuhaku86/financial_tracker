import 'package:financial_tracker/Applications/usecase/get_transaction_type_usecase.dart';
import 'package:financial_tracker/Commons/exceptions/domain_error_translator.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Interfaces/widgets/transaction_page/transaction_tile.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/transaction_repository.mocks.dart';

void main() {
  group("GetTransactionTypeUsecase class", () {
    const id = 345;
    const name = "get_transaction_type_name_test";

    test('execution success', () async {
      final transactionRepository = MockTransactionRepository();
      final transactionType = TransactionType(id: id, name: name);

      when(transactionRepository.getTransactionType(id))
          .thenAnswer((_) async => transactionType);

      final usecase = GetTransactionTypeUsecase(
          transactionRepository: transactionRepository);

      final result = await usecase.execute(id);

      expect(result.id, transactionType.id);
      expect(result.name, transactionType.name);
    });

    test('execution failed because no transaction type with id existed yet',
        () {
      final transactionRepository = MockTransactionRepository();
      final errorTranslator = DomainErrorTranslator();

      when(transactionRepository.getTransactionType(id)).thenThrow(
          errorTranslator.translate(ExceptionEnum.transactionTypeNotFound));

      final usecase = GetTransactionTypeUsecase(
          transactionRepository: transactionRepository);

      expect(
          usecase.execute(id),
          throwsA(errorTranslator
              .translate(ExceptionEnum.transactionTypeNotFound)));
    });
  });
}
