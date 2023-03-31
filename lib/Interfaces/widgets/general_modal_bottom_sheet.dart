import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/material.dart';

Future<void> showGeneralBottomSheet(
    {required BuildContext context,
    required Widget child,
    required double height}) async {
  showModalBottomSheet<void>(
      elevation: 2.0,
      barrierColor: themeColor.secondary.withOpacity(0.075),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: themeColor.primary,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          height: height,
          decoration: BoxDecoration(
            color: themeColor.primary,
            boxShadow: [
              BoxShadow(
                color: themeColor.secondary.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: child,
        );
      });
}
