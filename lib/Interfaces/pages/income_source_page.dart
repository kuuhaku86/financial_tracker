import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Domains/sources/entities/source.dart';
import 'package:financial_tracker/Domains/sources/source_repository.dart';
import 'package:financial_tracker/Interfaces/pages/add_income_source_page.dart';
import 'package:financial_tracker/Interfaces/widgets/button_custom.dart';
import 'package:financial_tracker/Interfaces/widgets/income_source_page/income_source_tile.dart';
import 'package:financial_tracker/Interfaces/widgets/list_tile_custom.dart';
import 'package:financial_tracker/Infrastructures/container.dart'
    as dependency_container;
import 'package:flutter/material.dart';

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
    SourceRepository repository = dependency_container.Container.container
        .getInstance(SourceRepository) as SourceRepository;

    return FutureBuilder(
      future: repository.getSources(),
      builder: (BuildContext context, AsyncSnapshot<List<Source>> snapshot) {
        if (ConnectionState.done == snapshot.connectionState) {
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
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTileCustom(
                              color: themeColor.secondary,
                              child: IncomeSourceTile(
                                id: snapshot.data![index].id,
                                incomeSourceName: snapshot.data![index].name,
                                imageRoute: snapshot.data![index].imageRoute,
                                onTap: () {},
                              ),
                            );
                          }),
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
                          Navigator.pushNamed(
                              context, AddIncomeSourcePage.route);
                        }),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
