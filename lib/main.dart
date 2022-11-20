import 'package:financial_tracker/Interfaces/pages/home_page.dart';
import 'package:financial_tracker/Interfaces/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: SplashScreenPage.route,
    routes: <String, WidgetBuilder>{
      SplashScreenPage.route: (context) => const SplashScreenPage(),
      HomePage.route: (context) => const HomePage(title: "Financial Tracker"),
    },
  ));
}
