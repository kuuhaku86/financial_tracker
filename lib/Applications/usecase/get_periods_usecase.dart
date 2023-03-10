import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetPeriodsUsecase {
  TransactionRepository transactionRepository;

  GetPeriodsUsecase({required this.transactionRepository});

  Future<List<Period>> execute() async {
    return await transactionRepository.getPeriods();
  }
}
