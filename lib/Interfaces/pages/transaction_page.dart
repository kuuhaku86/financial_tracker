import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Infrastructures/providers/model/income_source_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/period_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/transaction_type_list_model.dart';
import 'package:financial_tracker/Interfaces/pages/add_or_edit_transaction_page.dart';
import 'package:financial_tracker/Interfaces/widgets/list_tile_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/transaction_page/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);
  static const String route = "/main/transaction_page";

  @override
  State<StatefulWidget> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    Provider.of<TransactionListModel>(context, listen: false).refresh();
    Provider.of<TransactionTypeListModel>(context, listen: false).refresh();
    Provider.of<IncomeSourceListModel>(context, listen: false).refresh();
    TransactionTypeListModel? transactionTypeListModel;

    return SizedBox(
      height: mediaQuerySize.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: mediaQuerySize.height,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer<IncomeSourceListModel>(
                  builder: (context, sourceListModel, _) {
                    return Consumer<TransactionListModel>(
                      builder: (context, transactionListModel, _) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transactionListModel.transactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              final transaction = transactionListModel
                                  .transactions.reversed
                                  .toList()[index];
                              Source? source;
                              for (Source tempSource
                                  in sourceListModel.sources) {
                                if (tempSource.id == transaction.sourceId) {
                                  source = tempSource;
                                  break;
                                }
                              }

                              transactionTypeListModel ??=
                                  Provider.of<TransactionTypeListModel>(context,
                                      listen: false);

                              return ListTileCustom(
                                color: transaction.transactionTypeId ==
                                        transactionTypeListModel!
                                            .transactionTypes.first.id
                                    ? themeColor.secondary
                                    : themeColor.danger,
                                child: TransactionTile(
                                  transaction: transaction,
                                  transactionType: transactionTypeListModel!
                                      .transactionTypes
                                      .firstWhere((transactionType) =>
                                          transactionType.id ==
                                          transaction.transactionTypeId),
                                  imageRoute:
                                      (source == null) ? "" : source.imageRoute,
                                  onTap: () {},
                                ),
                              );
                            });
                      },
                    );
                  },
                ),
              ],
            )),
          ),
          Positioned(
            bottom: mediaQuerySize.height * 0.05,
            right: mediaQuerySize.width * 0.05,
            child: FloatingActionButton(
              backgroundColor: themeColor.secondary,
              onPressed: () async {
                Provider.of<TransactionModel>(context, listen: false).clean();
                Provider.of<TransactionTypeListModel>(context, listen: false)
                    .refresh();
                await Provider.of<IncomeSourceListModel>(context, listen: false)
                    .refresh();

                if (context.mounted) {
                  if (Provider.of<IncomeSourceListModel>(context, listen: false)
                      .sources
                      .isEmpty) {
                    SnackBar snackBar = const SnackBar(
                      content: Text("Income Source is still empty"),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    return;
                  }

                  Provider.of<PeriodListModel>(context, listen: false)
                      .refresh();

                  Navigator.pushNamed(context, AddOrEditTransactionPage.route);
                }
              },
              child: Icon(
                Icons.add,
                color: themeColor.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
