import 'package:flutter/material.dart';

class AppColors {
  Color primary;
  Color secondary;
  Color text;
  Color danger;
  Color warning;
  Color darkText;

  AppColors(
      {required this.primary,
      required this.secondary,
      required this.text,
      required this.danger,
      required this.warning,
      required this.darkText});
}

AppColors darkMode = AppColors(
    primary: const Color.fromRGBO(0, 0, 0, 1.0),
    secondary: const Color.fromRGBO(84, 199, 103, 1.0),
    text: const Color.fromRGBO(255, 255, 255, 1.0),
    danger: const Color.fromRGBO(255, 0, 0, 1.0),
    warning: const Color.fromRGBO(255, 255, 255, 1.0),
    darkText: const Color.fromRGBO(132, 132, 130, 1.0));

AppColors themeColor = darkMode;
