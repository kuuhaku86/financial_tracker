class RecurringTransaction {
  late int id;
  late int transactionId;
  late int numberInPeriod;
  late int periodId;

  RecurringTransaction(
      {required this.id,
      required this.transactionId,
      required this.numberInPeriod,
      required this.periodId});

  RecurringTransaction.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int;
    transactionId = map['transaction_id'] as int;
    numberInPeriod = map['number_in_period'] as int;
    periodId = map['period_id'] as int;
  }
}
