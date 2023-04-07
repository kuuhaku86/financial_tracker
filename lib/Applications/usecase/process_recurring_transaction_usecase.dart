import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class ProcessRecurringTransactionUsecase {
  TransactionRepository transactionRepository;

  ProcessRecurringTransactionUsecase({required this.transactionRepository});

  Future<void> execute() async {
    List<RecurringTransaction> recurringTransactions =
        await transactionRepository.getRecurringTransactions();
    DateTime now = DateTime.now();

    for (RecurringTransaction recurringTransaction in recurringTransactions) {
      Transaction transaction = await transactionRepository
          .getTransaction(recurringTransaction.transactionId);
      Period period =
          await transactionRepository.getPeriod(recurringTransaction.periodId);
      DateTime recurringTransactionPeriod = transaction.date;

      while (true) {
        if (period.name == "Days") {
          recurringTransactionPeriod = recurringTransactionPeriod
              .add(Duration(days: recurringTransaction.numberInPeriod));
        } else if (period.name == "Months") {
          recurringTransactionPeriod = DateTime(
              recurringTransactionPeriod.year,
              recurringTransactionPeriod.month +
                  recurringTransaction.numberInPeriod,
              recurringTransactionPeriod.day);
        } else if (period.name == "Years") {
          recurringTransactionPeriod = DateTime(
              recurringTransactionPeriod.year +
                  recurringTransaction.numberInPeriod,
              recurringTransactionPeriod.month,
              recurringTransactionPeriod.day);
        }

        bool needUpdateTransaction = now.isAfter(recurringTransactionPeriod);

        if (needUpdateTransaction) {
          final newTransaction =
              await transactionRepository.addTransaction(<String, Object>{
            "transaction_type_id": transaction.transactionTypeId,
            "source_id": transaction.sourceId,
            "name": transaction.name,
            "amount": transaction.amount,
            "detail": transaction.detail,
          });

          recurringTransaction.transactionId = newTransaction.id;

          await transactionRepository
              .updateRecurringTransaction(recurringTransaction);
        } else {
          break;
        }
      }
    }
  }
}
