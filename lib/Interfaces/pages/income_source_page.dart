import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/income_source_page/income_source_tile.dart';
import 'package:financial_tracker/Interfaces/widgets/list_tile_custom.dart';
import 'package:flutter/material.dart';

class IncomeSourcePage extends StatefulWidget {
  const IncomeSourcePage({Key? key}) : super(key: key);
  static const String route = "/main/income_source_page";

  @override
  State<StatefulWidget> createState() => _IncomeSourcePageState();
}

class _IncomeSourcePageState extends State<IncomeSourcePage> {
  List<Source> sourceList = [
    Source(id: 1, name: "Bank One", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Two", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
    Source(id: 1, name: "Bank Three", imageRoute: "assets/images/logo.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  itemCount: sourceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTileCustom(
                      color: themeColor.secondary,
                      child: IncomeSourceTile(
                        incomeSourceName: sourceList[index].name,
                        imageRoute: sourceList[index].imageRoute,
                        onTap: () {},
                      ),
                    );
                  }),
            ],
          )),
          Positioned(
            bottom: 0.0,
            child: ButtonCustom(
                icon: Icons.add, text: "Add New Income Source", onTap: () {}),
          ),
        ],
      ),
    );
  }
}
