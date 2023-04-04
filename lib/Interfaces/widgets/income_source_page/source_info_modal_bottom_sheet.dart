import 'dart:io';

import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Infrastructures/providers/model/source_model.dart';
import 'package:financial_tracker/Interfaces/widgets/general_modal_bottom_sheet.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SourceInfoModalBottomSheet {
  static showModal(BuildContext context, int sourceId) async {
    final mediaQuerySize = MediaQuery.of(context).size;
    await Provider.of<IncomeSourceModel>(context, listen: false)
        .getSource(sourceId);

    if (context.mounted) {
      showGeneralBottomSheet(
          context: context,
          child: Consumer<IncomeSourceModel>(
              builder: (context, incomeSourceModel, _) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                        ImageCustom(
                            imageProvider: FileImage(
                                File(incomeSourceModel.source!.imageRoute))),
                        SizedBox(
                          width: mediaQuerySize.width * 0.03,
                        ),
                        Text(
                          incomeSourceModel.source!.name,
                          style: TextStyle(color: themeColor.text),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Money at Source: ",
                      style: TextStyle(
                          color: themeColor.text, fontWeight: FontWeight.w600),
                    ),
                    Text(incomeSourceModel.reserveAmountAtSource.toString(),
                        style: TextStyle(color: themeColor.text)),
                  ],
                )
              ],
            ));
          }),
          height: mediaQuerySize.height * 0.25);
    }
  }
}
