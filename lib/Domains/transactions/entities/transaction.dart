class Transaction {
  late int id;
  late int transactionTypeId;
  late int sourceId;
  late String name;
  late String explanation;
  late double amount;

  Transaction(
      {required this.id,
      required this.transactionTypeId,
      required this.sourceId,
      required this.name,
      required this.explanation,
      required this.amount});

  Transaction.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    transactionTypeId = map['transaction_type_id'] as int;
    sourceId = map['source_id'] as int;
    name = map['name'] as String;
    explanation = map['explanation'] as String;
    amount = map['amount'] as double;
  }
}
