class AddSource {
  String name;
  String imageRoute;

  AddSource({required this.name, required this.imageRoute});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'image_route': imageRoute
    };

    return map;
  }
}
