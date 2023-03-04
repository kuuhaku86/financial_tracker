import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/widgets/image_custom.dart';
import 'package:flutter/material.dart';

class IncomeSourceTile extends StatelessWidget {
  final String incomeSourceName;
  final String imageRoute;
  final int id;
  final void Function() onTap;

  const IncomeSourceTile(
      {super.key,
      required this.incomeSourceName,
      required this.imageRoute,
      required this.id,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ImageCustom(imageProvider: AssetImage(imageRoute)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          Text(
            incomeSourceName,
            style: TextStyle(color: themeColor.text),
          ),
        ],
      ),
    );
  }
}
