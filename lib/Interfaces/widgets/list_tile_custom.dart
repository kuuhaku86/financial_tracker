import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  final Color color;
  final Widget child;

  const ListTileCustom({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      height: MediaQuery.of(context).size.height * 0.085,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: color, width: 2.5)),
          gradient: LinearGradient(
              colors: [themeColor.primary, color.withOpacity(0.5)])),
      child: child,
    );
  }
}
