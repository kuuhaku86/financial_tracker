import 'package:financial_tracker/Interfaces/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});
  static const String route = "/splash_screen";

  @override
  Widget build(BuildContext context) {
    // navigate(context);
    const String logoPath = "assets/images/logo.png";
    double padding = MediaQuery.of(context).size.width * 0.15;

    return Scaffold(
      backgroundColor: Colors.white12,
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
      Navigator.pushReplacementNamed(context, HomePage.route);
    });
  }
}
