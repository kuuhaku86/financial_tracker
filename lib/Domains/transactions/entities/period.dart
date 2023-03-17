class Period {
  late int id;
  late String name;
  late int days;

  Period({required this.id, required this.name, required this.days});

  Period.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    days = map['days'] as int;
  }
}
