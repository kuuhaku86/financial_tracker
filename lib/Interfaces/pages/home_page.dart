import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Infrastructures/providers/model/home_page_statistics_model.dart';
import 'package:financial_tracker/Interfaces/widgets/home_page/box_content.dart';
import 'package:financial_tracker/Interfaces/widgets/home_page/summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' show NumberFormat;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = "/main/home";

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomePageStatisticsModel>(context, listen: false).refresh();

    return SingleChildScrollView(
      child: Consumer<HomePageStatisticsModel>(
          builder: (context, homePageStatisticsModel, _) {
        return Column(
          children: [
            BoxContent(
              title: "Financial Charts",
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(
                      labelStyle: TextStyle(color: themeColor.text),
                    ),
                    primaryYAxis: NumericAxis(
                        labelStyle: TextStyle(color: themeColor.text),
                        numberFormat: NumberFormat("#")),
                    series: <LineSeries>[
                      LineSeries<Transaction, DateTime>(
                          dataSource:
                              homePageStatisticsModel.last30DaysTransactions,
                          xValueMapper: (Transaction transaction, _) =>
                              transaction.date,
                          yValueMapper: (Transaction transaction, _) =>
                              transaction.amount)
                    ]),
              ),
            ),
            Summary(
              homePageStatisticsModel: homePageStatisticsModel,
            ),
          ],
        );
      }),
    );
  }
}
