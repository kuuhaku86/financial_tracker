import 'dart:collection';

import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class IncomeSourceListModel extends ChangeNotifier {
  List<Source> _sources = [];
  final SourceRepository repository = dependency_container.Container.container
      .getInstance(SourceRepository) as SourceRepository;

  UnmodifiableListView<Source> get sources => UnmodifiableListView(_sources);

  void refresh() async {
    _sources = await repository.getSources();

    notifyListeners();
  }
}
