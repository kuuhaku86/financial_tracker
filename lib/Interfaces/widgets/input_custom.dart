import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  final Widget child;
  final String title;

  const InputCustom({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.025,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.0005,
      ),
      decoration: BoxDecoration(
        color: themeColor.primary,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: themeColor.darkText,
            spreadRadius: 0.5,
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: themeColor.text,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.w600,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
