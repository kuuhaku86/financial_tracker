import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarItemCustom {
  BottomNavigationBarItemCustom({required this.icon});

  IconData icon;

  BottomNavigationBarItem build(BuildContext context) {
    return BottomNavigationBarItem(
      activeIcon: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: themeColor.secondary, width: 2.0))),
        child: Icon(
          icon,
          color: themeColor.text,
        ),
      ),
      icon: Icon(
        icon,
        color: themeColor.darkText,
      ),
      label: "",
    );
  }
}
