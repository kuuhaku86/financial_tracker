import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Infrastructures/providers/model/home_page_statistics_model.dart';
import 'package:financial_tracker/Interfaces/widgets/home_page/box_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

class Summary extends StatelessWidget {
  HomePageStatisticsModel homePageStatisticsModel;

  Summary({super.key, required this.homePageStatisticsModel});

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
                    getNumberTextWithSign(
                        homePageStatisticsModel.incomeThisMonth.toString(),
                        homePageStatisticsModel.incomeThisMonth > 0
                            ? themeColor.secondary
                            : themeColor.danger),
                  ],
                ))),
        BoxContent(
            title: "Total Outcome This Month",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getNumberTextWithSign(
                        homePageStatisticsModel.outcomeThisMonth > 0
                            ? (homePageStatisticsModel.outcomeThisMonth * -1)
                                .toString()
                            : homePageStatisticsModel.outcomeThisMonth
                                .toString(),
                        homePageStatisticsModel.outcomeThisMonth > 0
                            ? themeColor.danger
                            : themeColor.secondary),
                  ],
                ))),
        BoxContent(
            title: "Difference With Last Month",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getNumberTextWithSign(
                        homePageStatisticsModel.differenceThanLastMonth
                            .toString(),
                        homePageStatisticsModel.differenceThanLastMonth > 0
                            ? themeColor.secondary
                            : themeColor.danger),
                  ],
                ))),
        BoxContent(
            title: "Total Wealth",
            child: getChild(
                context,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getTextWidget(
                        NumberFormat.currency(symbol: '\$')
                            .format(homePageStatisticsModel.totalWealth),
                        homePageStatisticsModel.totalWealth > 0
                            ? themeColor.secondary
                            : themeColor.danger),
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
    double textDouble = double.parse(text);

    if (textDouble > 0) {
      text = myFormat.format(textDouble);
      text = "+$text";
    }

    return getNumberText(text, color);
  }

  getNumberText(String text, Color color) {
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    return getTextWidget(
        text[0] == "+" ? text : myFormat.format(double.parse(text)), color);
  }

  getTextWidget(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 37.5,
          fontFamily: 'Segoe UI',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          color: color),
    );
  }
}
