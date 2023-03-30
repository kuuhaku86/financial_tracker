import 'dart:collection';

import 'package:financial_tracker/Applications/usecase/get_sources_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class IncomeSourceListModel extends ChangeNotifier {
  List<Source> _sources = [];
  final GetSourcesUsecase usecase = dependency_container.Container.container
      .getInstance(GetSourcesUsecase) as GetSourcesUsecase;

  UnmodifiableListView<Source> get sources => UnmodifiableListView(_sources);

  Future<void> refresh() async {
    _sources = await usecase.execute();

    notifyListeners();
  }
}
