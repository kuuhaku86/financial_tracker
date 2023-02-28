import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/widgets/box_content.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxContent(
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Current Asset",
                        style: getTitleTextStyle(themeColor.text)),
                    Text(
                      "1000",
                      style: getNumberTextStyle(themeColor.secondary),
                    )
                  ],
                ))),
        BoxContent(
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Comparison From Last Month",
                        textAlign: TextAlign.center,
                        style: getTitleTextStyle(themeColor.text)),
                    Text(
                      "1000",
                      style: getNumberTextStyle(Colors.green),
                    )
                  ],
                ))),
        BoxContent(
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Income Compared to Last Month",
                        style: getTitleTextStyle(themeColor.text)),
                    Text(
                      "1000",
                      style: getNumberTextStyle(Colors.red),
                    )
                  ],
                ))),
        BoxContent(
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Outcome Compared to Last Month",
                        style: getTitleTextStyle(themeColor.text)),
                    Text(
                      "1000",
                      style: getNumberTextStyle(Colors.green),
                    )
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

  getTitleTextStyle(Color color) {
    return TextStyle(
        fontSize: 20.0,
        fontFamily: 'Segoe UI',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: color);
  }

  getNumberTextStyle(Color color) {
    return TextStyle(
        fontSize: 35.0,
        fontFamily: 'Segoe UI',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w900,
        color: color);
  }
}
