import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Interfaces/widgets/home_page/box_content.dart';
import 'package:financial_tracker/Interfaces/widgets/home_page/summary.dart';
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
            title: "Financial Charts",
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: SfCartesianChart(
                  primaryXAxis: NumericAxis(
                    labelStyle: TextStyle(color: themeColor.text),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(color: themeColor.text),
                  ),
                  series: <LineSeries<Transaction, int>>[
                    LineSeries<Transaction, int>(
                        color: themeColor.secondary,
                        dataSource: <Transaction>[
                          Transaction(
                            id: 200,
                            transactionTypeId: 1,
                            sourceId: 1,
                            name: "test",
                            detail: "test",
                            amount: 2000,
                            date: DateTime.now(),
                          ),
                          Transaction(
                            id: 300,
                            transactionTypeId: 1,
                            sourceId: 1,
                            name: "test",
                            detail: "test",
                            amount: 3000,
                            date: DateTime.now(),
                          ),
                          Transaction(
                            id: 400,
                            transactionTypeId: 1,
                            sourceId: 1,
                            name: "test",
                            detail: "test",
                            amount: 4000,
                            date: DateTime.now(),
                          ),
                          Transaction(
                            id: 500,
                            transactionTypeId: 1,
                            sourceId: 1,
                            name: "test",
                            detail: "test",
                            amount: 5000,
                            date: DateTime.now(),
                          ),
                          Transaction(
                            id: 600,
                            transactionTypeId: 1,
                            sourceId: 1,
                            name: "test",
                            detail: "test",
                            amount: 5000,
                            date: DateTime.now(),
                          ),
                        ],
                        xValueMapper: (Transaction transaction, _) =>
                            transaction.id,
                        yValueMapper: (Transaction transaction, _) =>
                            transaction.amount)
                  ]),
            ),
          ),
          const Summary(),
        ],
      ),
    );
  }
}
