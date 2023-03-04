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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025,
            vertical: MediaQuery.of(context).size.height * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        height: MediaQuery.of(context).size.height * 0.085,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          color: HSLColor.fromColor(themeColor.secondary)
              .withLightness(0.3)
              .toColor(),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: themeColor.text,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Text(
              text,
              style: TextStyle(color: themeColor.text),
            )
          ],
        ),
      ),
    );
  }
}
