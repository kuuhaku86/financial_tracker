import 'package:flutter/material.dart';

class ImageCustom extends StatelessWidget {
  final ImageProvider imageProvider;

  const ImageCustom({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
      ),
    );
  }
}
