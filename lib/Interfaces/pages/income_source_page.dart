import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Infrastructures/providers/model/income_source_list_model.dart';
import 'package:financial_tracker/Infrastructures/providers/model/source_model.dart';
import 'package:financial_tracker/Interfaces/pages/add_or_edit_income_source_page.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/income_source_page/income_source_tile.dart';
import 'package:financial_tracker/Interfaces/widgets/list_tile_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeSourcePage extends StatefulWidget {
  const IncomeSourcePage({Key? key}) : super(key: key);
  static const String route = "/main/income_source_page";

  @override
  State<StatefulWidget> createState() => _IncomeSourcePageState();
}

class _IncomeSourcePageState extends State<IncomeSourcePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    Provider.of<IncomeSourceListModel>(context, listen: false).refresh();

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
                  builder: (context, incomeSourceListModel, _) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: incomeSourceListModel.sources.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTileCustom(
                            key: ValueKey(
                                incomeSourceListModel.sources[index].id),
                            color: themeColor.secondary,
                            child: IncomeSourceTile(
                              id: incomeSourceListModel.sources[index].id,
                              incomeSourceName:
                                  incomeSourceListModel.sources[index].name,
                              imageRoute: incomeSourceListModel
                                  .sources[index].imageRoute,
                            ),
                          );
                        });
                  },
                ),
              ],
            )),
          ),
          Positioned(
            bottom: 0.0,
            child: Align(
              alignment: Alignment.center,
              child: ButtonCustom(
                  icon: Icons.add,
                  text: "Add New Income Source",
                  onTap: () {
                    Provider.of<IncomeSourceModel>(context, listen: false)
                        .clean();

                    Navigator.pushNamed(
                        context, AddOrEditIncomeSourcePage.route);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
