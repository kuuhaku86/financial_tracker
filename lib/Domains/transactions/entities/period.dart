class Period {
  late int id;
  late String name;

  Period({required this.id, required this.name});

  Period.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
  }
}
