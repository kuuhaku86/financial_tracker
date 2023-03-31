import 'dart:io';

import 'package:financial_tracker/Applications/usecase/get_period_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_recurring_transaction_by_transaction_id_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_type_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Interfaces/widgets/general_modal_bottom_sheet.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;

class TransactionInfoModalBottomSheet {
  static showModal(BuildContext context, int transactionId) async {
    final mediaQuerySize = MediaQuery.of(context).size;
    final GetTransactionUsecase getTransactionUsecase = dependency_container
        .Container.container
        .getInstance(GetTransactionUsecase) as GetTransactionUsecase;
    final GetTransactionTypeUsecase getTransactionTypeUsecase =
        dependency_container.Container.container
                .getInstance(GetTransactionTypeUsecase)
            as GetTransactionTypeUsecase;
    final GetSourceUsecase getSourceUsecase =
        dependency_container.Container.container.getInstance(GetSourceUsecase)
            as GetSourceUsecase;
    final GetRecurringTransactionByTransactionIdUsecase
        getRecurringTransactionByTransactionIdUsecase = dependency_container
                .Container.container
                .getInstance(GetRecurringTransactionByTransactionIdUsecase)
            as GetRecurringTransactionByTransactionIdUsecase;
    final GetPeriodUsecase getPeriodUsecase =
        dependency_container.Container.container.getInstance(GetPeriodUsecase)
            as GetPeriodUsecase;
    final Transaction transaction =
        await getTransactionUsecase.execute(transactionId);
    final TransactionType transactionType =
        await getTransactionTypeUsecase.execute(transaction.transactionTypeId);
    final Source source = await getSourceUsecase.execute(transaction.sourceId);
    RecurringTransaction? recurringTransaction;
    Period? period;

    try {
      recurringTransaction = await getRecurringTransactionByTransactionIdUsecase
          .execute(transactionId: transactionId);
      period = await getPeriodUsecase.execute(
          periodId: recurringTransaction.periodId);
    } catch (e) {
      // if there's no recurring transaction
      print(e);
    }

    if (context.mounted) {
      List<Widget> widgetList = [
        generateRow("Name:", transaction.name),
        generateRow("Detail:", transaction.explanation),
        generateRow("Transaction Type:", transactionType.name),
        generateRow("Transaction Amount:", transaction.amount.toString()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Income Source:",
              style: TextStyle(
                  color: themeColor.text, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageCustom(imageProvider: FileImage(File(source.imageRoute))),
                SizedBox(
                  width: mediaQuerySize.width * 0.03,
                ),
                Text(
                  source.name,
                  style: TextStyle(color: themeColor.text),
                ),
              ],
            ),
          ],
        ),
      ];

      if (recurringTransaction != null) {
        widgetList.add(generateRow("Repeat Every:",
            "${recurringTransaction.numberInPeriod} ${period!.name}"));
      }

      showGeneralBottomSheet(
          context: context,
          child: SizedBox(
            height: mediaQuerySize.height * 0.4,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widgetList,
            )),
          ),
          height: mediaQuerySize.height * 0.45);
    }
  }

  static Row generateRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: themeColor.text, fontWeight: FontWeight.w600),
        ),
        Text(value, style: TextStyle(color: themeColor.text)),
      ],
    );
  }
}
