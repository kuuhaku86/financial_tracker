import 'package:financial_tracker/Domains/transactions/entities/period.dart';

class AddTransaction {
  int transactionTypeId;
  int sourceId;
  String name;
  String explanation;
  double amount;
  bool isRecurrent;
  int? numberInPeriod;
  Period? period;

  AddTransaction(
      {required this.transactionTypeId,
      required this.sourceId,
      required this.name,
      required this.explanation,
      required this.amount,
      this.isRecurrent = false,
      this.numberInPeriod,
      this.period});
}
