import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transactions_by_source_id_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class IncomeSourceModel extends ChangeNotifier {
  Source? _source;
  double _reserveAmountAtSource = 0;

  final GetSourceUsecase getSourceUsecase =
      dependency_container.Container.container.getInstance(GetSourceUsecase)
          as GetSourceUsecase;
  final GetTransactionsBySourceIdUsecase getTransactionsBySourceIdUsecase =
      dependency_container.Container.container
              .getInstance(GetTransactionsBySourceIdUsecase)
          as GetTransactionsBySourceIdUsecase;

  Source? get source => _source;
  double get reserveAmountAtSource => _reserveAmountAtSource;

  Future<void> getSource(int sourceId) async {
    _source = await getSourceUsecase.execute(sourceId);
    List<Transaction> transactions =
        await getTransactionsBySourceIdUsecase.execute(sourceId);
    _reserveAmountAtSource = 0;

    for (Transaction transaction in transactions) {
      if (transaction.transactionTypeId == 1) {
        _reserveAmountAtSource += transaction.amount;
      } else {
        _reserveAmountAtSource -= transaction.amount;
      }
    }

    notifyListeners();
  }

  void clean() {
    _source = null;
    _reserveAmountAtSource = 0;
  }
}
