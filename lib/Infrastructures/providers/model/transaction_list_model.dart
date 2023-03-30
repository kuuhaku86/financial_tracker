import 'dart:collection';

import 'package:financial_tracker/Applications/usecase/get_transactions_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

class TransactionListModel extends ChangeNotifier {
  List<Transaction> _transactions = [];
  final GetTransactionsUsecase usecase = dependency_container
      .Container.container
      .getInstance(GetTransactionsUsecase) as GetTransactionsUsecase;

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_transactions);

  Future<void> refresh() async {
    _transactions = await usecase.execute();

    notifyListeners();
  }
}
