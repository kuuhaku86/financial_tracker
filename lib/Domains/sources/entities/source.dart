class Source {
  late int id;
  late String name;
  late String imageRoute;

  Source({required this.id, required this.name, required this.imageRoute});

  Source.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] as int;
    name = map['name'] as String;
    imageRoute = map['image_route'] as String;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
      'image_route': imageRoute
    };

    return map;
  }
}
