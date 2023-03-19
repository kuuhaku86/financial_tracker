import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class IncomeSourceModel extends ChangeNotifier {
  Source? _source;
  final SourceRepository repository = dependency_container.Container.container
      .getInstance(SourceRepository) as SourceRepository;

  Source? get source => _source;

  void getSource(int sourceId) async {
    _source = await repository.getSource(sourceId);

    notifyListeners();
  }
}
