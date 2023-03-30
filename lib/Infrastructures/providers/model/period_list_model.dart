import 'dart:collection';

import 'package:financial_tracker/Applications/usecase/get_periods_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

class PeriodListModel extends ChangeNotifier {
  List<Period> _periods = [];
  final GetPeriodsUsecase usecase = dependency_container.Container.container
      .getInstance(GetPeriodsUsecase) as GetPeriodsUsecase;

  UnmodifiableListView<Period> get periods => UnmodifiableListView(_periods);

  Future<void> refresh() async {
    _periods = await usecase.execute();

    notifyListeners();
  }
}
