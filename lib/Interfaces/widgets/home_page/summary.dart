import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/widgets/home_page/box_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxContent(
            title: "Total Income This Month",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getNumberTextWithSign("10000", themeColor.secondary),
                  ],
                ))),
        BoxContent(
            title: "Total Outcome This Month",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getNumberTextWithSign("-2000", themeColor.danger),
                  ],
                ))),
        BoxContent(
            title: "Difference With Last Month",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getNumberText("200000", themeColor.secondary),
                  ],
                ))),
        BoxContent(
            title: "Total Wealth",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getNumberText("100000", themeColor.secondary),
                  ],
                ))),
      ],
    );
  }

  getChild(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.center,
      child: child,
    );
  }

  getNumberTextWithSign(String text, Color color) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    int textInt = int.parse(text);

    if (textInt > 0) {
      text = myFormat.format(textInt);
      text = "+$text";
    }

    return getNumberText(text, color);
  }

  getNumberText(String text, Color color) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return Text(
      text[0] == "+" ? text : myFormat.format(int.parse(text)),
      style: TextStyle(
          fontSize: 37.5,
          fontFamily: 'Segoe UI',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: color),
    );
  }
}
