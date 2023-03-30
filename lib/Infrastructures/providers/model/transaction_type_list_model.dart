import 'dart:collection';

import 'package:financial_tracker/Applications/usecase/get_transaction_types_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

class TransactionTypeListModel extends ChangeNotifier {
  List<TransactionType> _transactionTypes = [];
  final GetTransactionTypesUsecase usecase = dependency_container
      .Container.container
      .getInstance(GetTransactionTypesUsecase) as GetTransactionTypesUsecase;

  UnmodifiableListView<TransactionType> get transactionTypes =>
      UnmodifiableListView(_transactionTypes);

  Future<void> refresh() async {
    _transactionTypes = await usecase.execute();

    notifyListeners();
  }
}
