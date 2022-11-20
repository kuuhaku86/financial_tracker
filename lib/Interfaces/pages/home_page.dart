import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Interfaces/widgets/box_content.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = "/main/home";

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BoxContent(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: SfCartesianChart(
                  title: ChartTitle(
                      text: "Monthly Financial Condition",
                      textStyle: TextStyle(
                        color: themeColor.text,
                      )),
                  primaryXAxis: NumericAxis(
                    labelStyle: TextStyle(color: themeColor.text),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(color: themeColor.text),
                  ),
                  series: <LineSeries<Transaction, int>>[
                    LineSeries<Transaction, int>(
                        color: themeColor.selected,
                        dataSource: <Transaction>[
                          Transaction(
                              id: 1,
                              transactionTypeId: 1,
                              sourceId: 1,
                              explanation: "test",
                              amount: 2000),
                          Transaction(
                              id: 2,
                              transactionTypeId: 1,
                              sourceId: 1,
                              explanation: "test",
                              amount: 3000),
                          Transaction(
                              id: 3,
                              transactionTypeId: 1,
                              sourceId: 1,
                              explanation: "test",
                              amount: 4000),
                          Transaction(
                              id: 4,
                              transactionTypeId: 1,
                              sourceId: 1,
                              explanation: "test",
                              amount: 5000),
                        ],
                        xValueMapper: (Transaction transaction, _) =>
                            transaction.id,
                        yValueMapper: (Transaction transaction, _) =>
                            transaction.amount)
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
