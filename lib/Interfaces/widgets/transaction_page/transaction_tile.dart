import 'dart:io';

import 'package:financial_tracker/Applications/usecase/delete_transaction_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction_type.dart';
import 'package:financial_tracker/Infrastructures/providers/model/period_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_type_list_model.dart';
import 'package:financial_tracker/Interfaces/pages/add_or_edit_transaction_page.dart';
import 'package:financial_tracker/Interfaces/widgets/alert_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/transaction_page/transaction_info_modal_bottom_sheet.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionTile extends StatelessWidget {
  final String imageRoute;
  final void Function() onTap;
  final Transaction transaction;
  final TransactionType transactionType;

  const TransactionTile(
      {super.key,
      required this.transaction,
      required this.transactionType,
      required this.imageRoute,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageCustom(imageProvider: FileImage(File(imageRoute))),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: TextStyle(color: themeColor.text),
                  ),
                  Text(
                    transactionType.name == "Income"
                        ? "+${transaction.amount}"
                        : "-${transaction.amount}",
                    style: TextStyle(
                      color: themeColor.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.info,
                  color: themeColor.text,
                  size: mediaQuerySize.width * 0.09,
                ),
                onTap: () async {
                  await TransactionInfoModalBottomSheet.showModal(
                      context, transaction.id);
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: themeColor.text,
                  size: mediaQuerySize.width * 0.09,
                ),
                onTap: () async {
                  await Provider.of<PeriodListModel>(context, listen: false)
                      .refresh();

                  if (context.mounted) {
                    await Provider.of<TransactionTypeListModel>(context,
                            listen: false)
                        .refresh();
                  }

                  if (context.mounted) {
                    await Provider.of<TransactionModel>(context, listen: false)
                        .getTransaction(transaction.id);
                  }

                  if (context.mounted) {
                    Navigator.pushNamed(
                        context, AddOrEditTransactionPage.route);
                  }
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.delete_forever,
                  color: themeColor.text,
                  size: mediaQuerySize.width * 0.09,
                ),
                onTap: () {
                  AlertCustom.showAlertDialog(context,
                      "Are you sure you want to delete this transaction?",
                      () async {
                    try {
                      final DeleteTransactionUsecase deleteTransactionUsecase =
                          dependency_container.Container.container
                                  .getInstance(DeleteTransactionUsecase)
                              as DeleteTransactionUsecase;

                      await deleteTransactionUsecase.execute(transaction);

                      const SnackBar snackBar = SnackBar(
                        content: Text("Delete transaction success"),
                      );

                      if (context.mounted) {
                        Provider.of<TransactionListModel>(context,
                                listen: false)
                            .refresh();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      SnackBar snackBar = SnackBar(
                        content: Text(e.toString()),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
