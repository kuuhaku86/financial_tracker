import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class IncomeSourceModel extends ChangeNotifier {
  Source? _source;
  final GetSourceUsecase usecase = dependency_container.Container.container
      .getInstance(GetSourceUsecase) as GetSourceUsecase;

  Source? get source => _source;

  void getSource(int sourceId) async {
    _source = await usecase.execute(sourceId);

    notifyListeners();
  }
}
