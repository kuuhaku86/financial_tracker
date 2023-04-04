import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/transaction_repository.dart';

class GetHomePageStatisticsUsecase {
  TransactionRepository transactionRepository;

  GetHomePageStatisticsUsecase({required this.transactionRepository});

  Future<Map<String, Object>> execute() async {
    DateTime now = DateTime.now();

    DateTime lastMonth = DateTime(now.year, now.month - 1, now.day);
    DateTime lastDayOfLastMonth =
        DateTime(lastMonth.year, lastMonth.month + 1, 0);
    int lastDayOfLastMonthTimestamp = lastDayOfLastMonth.microsecondsSinceEpoch;
    DateTime firstDayOfLastMonth = DateTime(lastMonth.year, lastMonth.month, 1);
    int firstDayOfLastMonthTimestamp =
        firstDayOfLastMonth.microsecondsSinceEpoch;

    DateTime firstDayOfThisMonth = DateTime(now.year, now.month, 1);
    int firstDayOfThisMonthTimestamp =
        firstDayOfThisMonth.microsecondsSinceEpoch;

    DateTime last30Days = now.subtract(const Duration(days: 30));
    int last30DaysTimestamp = last30Days.microsecondsSinceEpoch;

    List<Transaction> lastMonthTransactions =
        await transactionRepository.getTransactionsWithTimeRange(
            firstDayOfLastMonthTimestamp, lastDayOfLastMonthTimestamp);
    List<Transaction> thisMonthTransactions =
        await transactionRepository.getTransactionsWithTimeRange(
            firstDayOfThisMonthTimestamp, now.microsecondsSinceEpoch);
    List<Transaction> last30DaysTransactions =
        await transactionRepository.getTransactionsWithTimeRange(
            last30DaysTimestamp, now.microsecondsSinceEpoch);
    List<Transaction> allTransactions =
        await transactionRepository.getTransactions();

    double totalOfLastMonth = 0;
    double incomeThisMonth = 0;
    double outcomeThisMonth = 0;
    double totalWealth = 0;
    double totalBefore30Days = 0;

    for (Transaction transaction in lastMonthTransactions) {
      if (transaction.transactionTypeId == 1) {
        totalOfLastMonth += transaction.amount;
      } else {
        totalOfLastMonth -= transaction.amount;
      }
    }

    for (Transaction transaction in thisMonthTransactions) {
      if (transaction.transactionTypeId == 1) {
        incomeThisMonth += transaction.amount;
      } else {
        outcomeThisMonth += transaction.amount;
      }
    }

    for (Transaction transaction in allTransactions) {
      if (transaction.transactionTypeId == 1) {
        totalWealth += transaction.amount;
      } else {
        totalWealth -= transaction.amount;
      }

      if (transaction.date.isBefore(last30Days)) {
        if (transaction.transactionTypeId == 1) {
          totalBefore30Days += transaction.amount;
        } else {
          totalBefore30Days -= transaction.amount;
        }
      }
    }

    for (int i = 0; i < last30DaysTransactions.length; i++) {
      double tempAmount = last30DaysTransactions[i].amount;

      if (last30DaysTransactions[i].transactionTypeId == 1) {
        last30DaysTransactions[i].amount = totalBefore30Days + tempAmount;
        totalBefore30Days += tempAmount;
      } else {
        last30DaysTransactions[i].amount = totalBefore30Days - tempAmount;
        totalBefore30Days -= tempAmount;
      }
    }

    return {
      "difference_than_last_month":
          (incomeThisMonth - outcomeThisMonth) - totalOfLastMonth,
      "income_this_month": incomeThisMonth,
      "outcome_this_month": outcomeThisMonth,
      "last_30_days_transactions": last30DaysTransactions,
      "total_wealth": totalWealth,
    };
  }
}
