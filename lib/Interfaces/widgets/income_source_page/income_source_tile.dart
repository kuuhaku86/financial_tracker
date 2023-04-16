import 'dart:io';

import 'package:financial_tracker/Applications/usecase/delete_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_source_usecase.dart';
import 'package:financial_tracker/Applications/usecase/get_transactions_by_source_id_usecase.dart';
import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Infrastructures/providers/model/income_source_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/source_model.dart';
import 'package:financial_tracker/Interfaces/pages/add_or_edit_income_source_page.dart';
import 'package:financial_tracker/Interfaces/widgets/alert_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/income_source_page/source_info_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:provider/provider.dart';

class IncomeSourceTile extends StatelessWidget {
  final String incomeSourceName;
  final String imageRoute;
  final int id;

  const IncomeSourceTile(
      {super.key,
      required this.incomeSourceName,
      required this.imageRoute,
      required this.id});

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ImageCustom(imageProvider: FileImage(File(imageRoute))),
            SizedBox(
              width: mediaQuerySize.width * 0.03,
            ),
            Text(
              incomeSourceName,
              style: TextStyle(color: themeColor.text),
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
                await Provider.of<IncomeSourceModel>(context, listen: false)
                    .getSource(id);
                
                if (context.mounted) {
                  await SourceInfoModalBottomSheet.showModal(context, id);
                }
              },
            ),
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: themeColor.text,
                size: mediaQuerySize.width * 0.09,
              ),
              onTap: () {
                Provider.of<IncomeSourceModel>(context, listen: false)
                    .getSource(id);
                Navigator.pushNamed(context, AddOrEditIncomeSourcePage.route);
              },
            ),
            GestureDetector(
              child: Icon(
                Icons.delete_forever,
                color: themeColor.text,
                size: mediaQuerySize.width * 0.09,
              ),
              onTap: () async {
                final GetTransactionsBySourceIdUsecase
                    getTransactionsBySourceIdUsecase = dependency_container
                            .Container.container
                            .getInstance(GetTransactionsBySourceIdUsecase)
                        as GetTransactionsBySourceIdUsecase;

                try {
                  List<Transaction> transactions =
                      await getTransactionsBySourceIdUsecase.execute(id);

                  if (transactions.isNotEmpty) {
                    const SnackBar snackBar = SnackBar(
                      content: Text(
                          "There's still some transactions that using this source"),
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                  }
                } catch (e) {
                  // If no transaction found, then continue
                }

                if (context.mounted) {
                  AlertCustom.showAlertDialog(
                      context, "Are you sure you want to delete this source?",
                      () async {
                    try {
                      final GetSourceUsecase getSourceUsecase =
                          dependency_container.Container.container
                                  .getInstance(GetSourceUsecase)
                              as GetSourceUsecase;
                      final DeleteSourceUsecase deleteSourceUsecase =
                          dependency_container.Container.container
                                  .getInstance(DeleteSourceUsecase)
                              as DeleteSourceUsecase;
                      final Source source = await getSourceUsecase.execute(id);
                      await deleteSourceUsecase.execute(source);

                      const SnackBar snackBar = SnackBar(
                        content: Text("Delete Source success"),
                      );

                      if (context.mounted) {
                        Provider.of<IncomeSourceListModel>(context,
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
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
