import 'package:financial_tracker/Applications/usecase/get_period_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_recurring_transaction_by_transaction_id_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_type_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_usecase.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  Transaction? _transaction;
  TransactionType? _transactionType;
  RecurringTransaction? _recurringTransaction;
  Period? _period;
  Source? _source;

  final GetTransactionUsecase _getTransactionUsecase = dependency_container
      .Container.container
      .getInstance(GetTransactionUsecase) as GetTransactionUsecase;
  final GetRecurringTransactionByTransactionIdUsecase
      _getRecurringTransactionByTransactionIdUsecase = dependency_container
              .Container.container
              .getInstance(GetRecurringTransactionByTransactionIdUsecase)
          as GetRecurringTransactionByTransactionIdUsecase;
  final GetPeriodUsecase _getPeriodUsecase =
      dependency_container.Container.container.getInstance(GetPeriodUsecase)
          as GetPeriodUsecase;
  final GetTransactionTypeUsecase _getTransactionTypeUsecase =
      dependency_container.Container.container
          .getInstance(GetTransactionTypeUsecase) as GetTransactionTypeUsecase;
  final GetSourceUsecase _getSourceUsecase =
      dependency_container.Container.container.getInstance(GetSourceUsecase)
          as GetSourceUsecase;

  Transaction? get transaction => _transaction;
  TransactionType? get transactionType => _transactionType;
  RecurringTransaction? get recurringTransaction => _recurringTransaction;
  Period? get period => _period;
  Source? get source => _source;

  Future<void> getTransaction(int transactionId) async {
    _transaction = await _getTransactionUsecase.execute(transactionId);
    _transactionType = await _getTransactionTypeUsecase
        .execute(_transaction!.transactionTypeId);
    _source = await _getSourceUsecase.execute(transaction!.sourceId);

    try {
      _recurringTransaction =
          await _getRecurringTransactionByTransactionIdUsecase
              .execute(_transaction!.id);
      if (_recurringTransaction != null) {
        _period =
            await _getPeriodUsecase.execute(_recurringTransaction!.periodId);
      }
    } catch (e) {
      _recurringTransaction = null;
      _period = null;
    }

    notifyListeners();
  }
}
