import 'dart:collection';

import 'package:financial_tracker/Applications/usecase/get_home_page_statistics.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

class HomePageStatisticsModel extends ChangeNotifier {
  List<Transaction> _last30DaysTransactions = [];
  double _differenceThanLastMonth = 0;
  double _outcomeThisMonth = 0;
  double _incomeThisMonth = 0;
  double _totalWealth = 0;

  final GetHomePageStatisticsUsecase usecase = dependency_container
          .Container.container
          .getInstance(GetHomePageStatisticsUsecase)
      as GetHomePageStatisticsUsecase;

  UnmodifiableListView<Transaction> get last30DaysTransactions =>
      UnmodifiableListView(_last30DaysTransactions);
  double get differenceThanLastMonth => _differenceThanLastMonth;
  double get outcomeThisMonth => _outcomeThisMonth;
  double get incomeThisMonth => _incomeThisMonth;
  double get totalWealth => _totalWealth;

  Future<void> refresh() async {
    Map<String, Object> result = await usecase.execute();

    _last30DaysTransactions =
        result["last_30_days_transactions"] as List<Transaction>;
    _differenceThanLastMonth = result["difference_than_last_month"] as double;
    _outcomeThisMonth = result["outcome_this_month"] as double;
    _incomeThisMonth = result["income_this_month"] as double;
    _totalWealth = result["total_wealth"] as double;

    notifyListeners();
  }
}
