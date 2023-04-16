import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onTap;

  const ButtonCustom(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: themeColor.secondary,
        fixedSize:
            Size(mediaQuerySize.width * 0.95, mediaQuerySize.height * 0.07),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: themeColor.text,
          ),
          SizedBox(
            width: mediaQuerySize.width * 0.01,
          ),
          Text(
            text,
            style: TextStyle(color: themeColor.text),
          )
        ],
      ),
    );
  }
}
