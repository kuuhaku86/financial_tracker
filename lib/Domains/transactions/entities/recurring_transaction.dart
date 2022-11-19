class RecurringTransaction {
  late int id;
  late int transactionId;
  late int timeRecurringInSecond;

  RecurringTransaction(
      {required this.id,
      required this.transactionId,
      required this.timeRecurringInSecond});

  RecurringTransaction.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    transactionId = map['transaction_id'] as int;
    timeRecurringInSecond = map['time_recurring_in_second'] as int;
  }
}
