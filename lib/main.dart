import 'package:financial_tracker/Infrastructures/init_config.dart';
import 'package:financial_tracker/Interfaces/pages/add_income_source_page.dart';
import 'package:financial_tracker/Interfaces/pages/add_transaction_page.dart';
import 'package:financial_tracker/Interfaces/pages/home_page.dart';
import 'package:financial_tracker/Interfaces/pages/income_source_page.dart';
import 'package:financial_tracker/Interfaces/pages/main_page.dart';
import 'package:financial_tracker/Interfaces/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initConfig();

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Poppins',
    ),
    initialRoute: SplashScreenPage.route,
    routes: <String, WidgetBuilder>{
      SplashScreenPage.route: (context) => const SplashScreenPage(),
      MainPage.route: (context) => const MainPage(),
      HomePage.route: (context) => const HomePage(),
      IncomeSourcePage.route: (context) => const IncomeSourcePage(),
      AddIncomeSourcePage.route: (context) => const AddIncomeSourcePage(),
      AddTransactionPage.route: (context) => const AddTransactionPage(),
    },
  ));
}
