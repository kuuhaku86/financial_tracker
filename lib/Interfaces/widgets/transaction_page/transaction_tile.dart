import 'dart:io';

import 'package:financial_tracker/Applications/usecase/delete_transaction_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transaction_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_list_model.dart';
import 'package:financial_tracker/Interfaces/widgets/alert_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/transaction_page/transaction_info_modal_bottom_sheet.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionTile extends StatelessWidget {
  final String transactionName;
  final double transactionAmount;
  final int id;
  final String imageRoute;
  final void Function() onTap;

  const TransactionTile(
      {super.key,
      required this.imageRoute,
      required this.onTap,
      required this.transactionName,
      required this.transactionAmount,
      required this.id});

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
                    transactionName,
                    style: TextStyle(color: themeColor.text),
                  ),
                  Text(
                    transactionAmount > 0
                        ? "+$transactionAmount"
                        : transactionAmount.toString(),
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
                  await TransactionInfoModalBottomSheet.showModal(context, id);
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: themeColor.text,
                  size: mediaQuerySize.width * 0.09,
                ),
                onTap: () {},
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
                      final GetTransactionUsecase getTransactionUsecase =
                          dependency_container.Container.container
                                  .getInstance(GetTransactionUsecase)
                              as GetTransactionUsecase;

                      final Transaction transaction =
                          await getTransactionUsecase.execute(id);
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
