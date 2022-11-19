class Source {
  late int id;
  late String name;
  late double initialAmount;

  Source({required this.id, required this.name, required this.initialAmount});

  Source.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    initialAmount = map['initial_amount'] as double;
  }
}
