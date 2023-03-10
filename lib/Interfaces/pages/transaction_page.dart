import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/transactions/entities/transaction.dart';
import 'package:financial_tracker/Interfaces/pages/add_transaction_page.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/list_tile_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/transaction_page/transaction_tile.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);
  static const String route = "/main/transaction_page";

  @override
  State<StatefulWidget> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Transaction> transactionList = [
    Transaction(
        id: 1,
        name: "Pay One",
        transactionTypeId: 1,
        sourceId: 1,
        explanation: "great",
        amount: 2000,
        date: DateTime.now()),
    Transaction(
        id: 1,
        name: "Pay Two",
        transactionTypeId: 1,
        sourceId: 2,
        explanation: "great",
        amount: -2000,
        date: DateTime.now()),
    Transaction(
        id: 1,
        name: "Pay Three",
        transactionTypeId: 1,
        sourceId: 1,
        explanation: "great",
        amount: -2000,
        date: DateTime.now()),
  ];
  List<Source> sourceList = [
    Source(id: 1, name: "Bank One", imageRoute: "assets/images/logo.png"),
    Source(id: 2, name: "Bank One", imageRoute: "assets/images/logo.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Source? source;
                    for (Source tempSource in sourceList) {
                      if (tempSource.id == transactionList[index].sourceId) {
                        source = tempSource;
                        break;
                      }
                    }

                    return ListTileCustom(
                      color: transactionList[index].amount > 0
                          ? themeColor.secondary
                          : themeColor.danger,
                      child: TransactionTile(
                        id: transactionList[index].id,
                        transactionName: transactionList[index].name,
                        transactionAmount: transactionList[index].amount,
                        imageRoute: (source == null) ? "" : source.imageRoute,
                        onTap: () {},
                      ),
                    );
                  }),
            ],
          )),
          Positioned(
            bottom: 0.0,
            child: ButtonCustom(
                icon: Icons.add,
                text: "Add New Transaction",
                onTap: () {
                  Navigator.pushNamed(context, AddTransactionPage.route);
                }),
          ),
        ],
      ),
    );
  }
}
