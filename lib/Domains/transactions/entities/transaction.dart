class Transaction {
  late int id;
  late int transactionTypeId;
  late int sourceId;
  late String name;
  late String detail;
  late double amount;
  late DateTime date;

  Transaction({
    required this.id,
    required this.transactionTypeId,
    required this.sourceId,
    required this.name,
    required this.detail,
    required this.amount,
    required this.date,
  });

  Transaction.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int;
    transactionTypeId = map['transaction_type_id'] as int;
    sourceId = map['source_id'] as int;
    name = map['name'] as String;
    detail = map['detail'] as String;
    amount = map['amount'] as double;
    date = DateTime.fromMicrosecondsSinceEpoch(map['date'] as int);
  }
}
