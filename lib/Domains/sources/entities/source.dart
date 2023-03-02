class Source {
  late int id;
  late String name;
  late String imageRoute;

  Source({required this.id, required this.name, required this.imageRoute});

  Source.fromMap(Map<String, Object?> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    imageRoute = map['image_route'] as String;
  }
}
