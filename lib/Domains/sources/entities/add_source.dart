import 'dart:io';

class AddSource {
  String name;
  File image;

  AddSource({required this.name, required this.image});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'image_route': image.path
    };

    return map;
  }
}
