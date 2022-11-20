import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});
  static const String route = "/splash_screen";

  @override
  Widget build(BuildContext context) {
    const String logoPath = "assets/images/logo.png";
    double padding = MediaQuery.of(context).size.width * 0.15;

    navigate(context);

    return Scaffold(
      backgroundColor: themeColor.main,
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(logoPath),
            SizedBox(height: padding),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
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
