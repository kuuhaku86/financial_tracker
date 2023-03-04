import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:financial_tracker/Interfaces/pages/home_page.dart';
import 'package:financial_tracker/Interfaces/pages/income_source_page.dart';
import 'package:financial_tracker/Interfaces/widgets/bottom_navigation_bar_item_custom.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String route = "/main";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _pagesOptions = <Widget>[
    HomePage(),
    IncomeSourcePage(),
    Text("test3"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: themeColor.primary,
      body: SafeArea(
        child: Center(
          child: _pagesOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeColor.primary,
        unselectedItemColor: themeColor.text,
        selectedItemColor: themeColor.secondary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItemCustom(icon: Icons.home).build(context),
          BottomNavigationBarItemCustom(icon: Icons.credit_card).build(context),
          BottomNavigationBarItemCustom(icon: Icons.attach_money)
              .build(context),
        ],
      ),
    );
  }
}
