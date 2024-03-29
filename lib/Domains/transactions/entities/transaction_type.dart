class TransactionType {
  late int id;
  late String name;

  TransactionType({required this.id, required this.name});

  TransactionType.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
  }
}
