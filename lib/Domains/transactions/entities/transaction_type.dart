class TransactionType {
  late int id;
  late String name;

  TransactionType({required this.id, required this.name});

  TransactionType.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    name = map['name'] as String;
  }
}
