import 'package:financial_tracker/Applications/usecase/process_recurring_transaction_usecase.dart';
import 'package:financial_tracker/Infrastructures/init_config.dart';
import 'package:financial_tracker/Infrastructures/providers/model/home_page_statistics_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/income_source_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/period_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/source_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_type_list_model.dart';
import 'package:financial_tracker/Interfaces/pages/add_or_edit_income_source_page.dart';
import 'package:financial_tracker/Interfaces/pages/add_or_edit_transaction_page.dart';
import 'package:financial_tracker/Interfaces/pages/home_page.dart';
import 'package:financial_tracker/Interfaces/pages/income_source_page.dart';
import 'package:financial_tracker/Interfaces/pages/main_page.dart';
import 'package:financial_tracker/Interfaces/pages/splash_screen_page.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initConfig();

  await (dependency_container.Container.container
              .getInstance(ProcessRecurringTransactionUsecase)
          as ProcessRecurringTransactionUsecase)
      .execute();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IncomeSourceListModel()),
        ChangeNotifierProvider(create: (context) => IncomeSourceModel()),
        ChangeNotifierProvider(create: (context) => TransactionListModel()),
        ChangeNotifierProvider(create: (context) => TransactionModel()),
        ChangeNotifierProvider(create: (context) => TransactionTypeListModel()),
        ChangeNotifierProvider(create: (context) => PeriodListModel()),
        ChangeNotifierProvider(create: (context) => HomePageStatisticsModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        initialRoute: SplashScreenPage.route,
        routes: <String, WidgetBuilder>{
          SplashScreenPage.route: (context) => const SplashScreenPage(),
          MainPage.route: (context) => const MainPage(),
          HomePage.route: (context) => const HomePage(),
          IncomeSourcePage.route: (context) => const IncomeSourcePage(),
          AddOrEditIncomeSourcePage.route: (context) =>
              const AddOrEditIncomeSourcePage(),
          AddOrEditTransactionPage.route: (context) =>
              const AddOrEditTransactionPage(),
        },
      ),
    ));
  });
}
