import 'package:flutter/material.dart';

class AppColors {
  Color main;
  Color secondary;
  Color text;
  Color selected;

  AppColors(
      {required this.main,
      required this.secondary,
      required this.text,
      required this.selected});
}

bool isDarkMode = true;

AppColors darkMode = AppColors(
    main: const Color.fromRGBO(45, 45, 48, 1.0),
    secondary: const Color.fromRGBO(62, 62, 66, 1.0),
    text: const Color.fromRGBO(255, 255, 255, 1.0),
    selected: const Color.fromRGBO(32, 105, 224, 1.0));

AppColors lightMode = AppColors(
    main: const Color.fromRGBO(255, 255, 255, 1.0),
    secondary: const Color.fromRGBO(255, 255, 255, 1.0),
    text: const Color.fromRGBO(45, 45, 48, 1.0),
    selected: const Color.fromRGBO(32, 105, 224, 1.0));

AppColors themeColor = isDarkMode ? darkMode : lightMode;

void switchColorThemeMode() {
  isDarkMode = !isDarkMode;
  themeColor = isDarkMode ? darkMode : lightMode;
}
