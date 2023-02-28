import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});
  static const String route = "/splash_screen";

  @override
  Widget build(BuildContext context) {
    navigate(context);

    return Scaffold(
      backgroundColor: themeColor.primary,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.width * 0.35,
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
              color: themeColor.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              "F",
              style: TextStyle(
                color: themeColor.text,
                fontSize: MediaQuery.of(context).size.width * 0.25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  navigate(BuildContext context) async {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, MainPage.route);
    });
  }
}
