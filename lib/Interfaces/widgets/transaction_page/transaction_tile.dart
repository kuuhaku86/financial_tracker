import 'dart:io';

import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:flutter/material.dart';

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
                  Icons.edit,
                  color: themeColor.text,
                  size: MediaQuery.of(context).size.width * 0.09,
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Icon(
                  Icons.delete_forever,
                  color: themeColor.text,
                  size: MediaQuery.of(context).size.width * 0.09,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
