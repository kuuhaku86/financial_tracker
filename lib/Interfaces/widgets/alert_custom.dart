import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/material.dart';

class AlertCustom {
  static showAlertDialog(
      BuildContext context, String question, Function() onContinue) {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: themeColor.secondary),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      onPressed: onContinue,
      child: Text(
        "Continue",
        style: TextStyle(color: themeColor.secondary),
      ),
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: themeColor.primary,
      shadowColor: themeColor.secondary,
      title: Text(
        question,
        style: TextStyle(color: themeColor.secondary),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
