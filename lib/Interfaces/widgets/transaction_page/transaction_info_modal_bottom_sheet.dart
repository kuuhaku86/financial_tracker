import 'dart:io';

import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/period.dart';
import 'package:financial_tracker/Domains/transactions/entities/recurring_transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_model.dart';
import 'package:financial_tracker/Interfaces/widgets/general_modal_bottom_sheet.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionInfoModalBottomSheet {
  static showModal(BuildContext context, int transactionId) async {
    final mediaQuerySize = MediaQuery.of(context).size;
    await Provider.of<TransactionModel>(context, listen: false)
        .getTransaction(transactionId);

    if (context.mounted) {
      final provider = Provider.of<TransactionModel>(context, listen: false);
      final Transaction transaction = provider.transaction!;

      final TransactionType transactionType = provider.transactionType!;
      final Source source = provider.source!;
      RecurringTransaction? recurringTransaction =
          provider.recurringTransaction;
      Period? period = provider.period;

      List<Widget> widgetList = [
        _generateRow("Name:", transaction.name),
        _generateRow("Detail:", transaction.explanation),
        _generateRow("Transaction Type:", transactionType.name),
        _generateRow("Transaction Amount:", transaction.amount.toString()),
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
        widgetList.add(_generateRow("Repeat Every:",
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

  static Row _generateRow(String label, String value) {
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
