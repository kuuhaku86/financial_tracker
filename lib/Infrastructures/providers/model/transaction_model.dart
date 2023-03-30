import 'package:financial_tracker/Applications/usecase/get_transaction_usecase.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  Transaction? _transaction;
  final GetTransactionUsecase usecase = dependency_container.Container.container
      .getInstance(GetTransactionUsecase) as GetTransactionUsecase;

  Transaction? get transaction => _transaction;

  void getTransaction(int transactionId) async {
    _transaction = await usecase.execute(transactionId);

    notifyListeners();
  }
}
