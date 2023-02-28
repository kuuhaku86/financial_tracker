import 'package:financial_tracker/Interfaces/pages/main_page.dart';
import 'package:financial_tracker/Interfaces/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Poppins',
    ),
    initialRoute: SplashScreenPage.route,
    routes: <String, WidgetBuilder>{
      SplashScreenPage.route: (context) => const SplashScreenPage(),
      MainPage.route: (context) => const MainPage(),
    },
  ));
}
