import 'package:financial_tracker/Domains/transactions/entities/add_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class UpdateTransactionsUsecase {
  TransactionRepository transactionRepository;

  UpdateTransactionsUsecase({required this.transactionRepository});

  Future<void> execute(
      Transaction transaction,
      RecurringTransaction? recurringTransaction,
      AddTransaction newData) async {
    if (recurringTransaction != null) {
      if (newData.isRecurring == false) {
        await transactionRepository
            .deleteRecurringTransaction(recurringTransaction.id);
      } else {
        recurringTransaction.numberInPeriod = newData.numberInPeriod!;
        recurringTransaction.periodId = newData.period!.id;

        await transactionRepository
            .updateRecurringTransaction(recurringTransaction);
      }
    } else if(newData.isRecurring) {
      await transactionRepository.addRecurringTransaction(<String, Object>{
        "transaction_id": transaction.id,
        "number_in_period": newData.numberInPeriod!,
        "period_id": newData.period!.id
      });
    }

    transaction.transactionTypeId = newData.transactionTypeId;
    transaction.sourceId = newData.sourceId;
    transaction.name = newData.name;
    transaction.detail = newData.detail;
    transaction.amount = newData.amount;

    await transactionRepository.updateTransaction(transaction);
  }
}
