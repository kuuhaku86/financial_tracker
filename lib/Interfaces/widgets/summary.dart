import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          "Summary",
          style: TextStyle(
            fontSize: 17.5,
            fontFamily: 'Segoe UI',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            color: themeColor.text,
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Current Asset: ",
                style: getSummaryTextStyle(themeColor.text)),
            Text(
              "1000",
              style: getSummaryTextStyle(themeColor.selected),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Comparison From Last Month: ",
              style: getSummaryTextStyle(themeColor.text),
            ),
            Text(
              "1000",
              style: getSummaryTextStyle(Colors.green),
            )
          ],
        ),
      ],
    );
  }

  getSummaryTextStyle(Color color) {
    return TextStyle(
        fontSize: 16.0,
        fontFamily: 'Segoe UI',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: color);
  }
}
