import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetPeriodUsecase {
  TransactionRepository transactionRepository;

  GetPeriodUsecase({required this.transactionRepository});

  Future<Period> execute(int periodId) async {
    return await transactionRepository.getPeriod(periodId);
  }
}
