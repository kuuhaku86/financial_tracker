import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/cupertino.dart';

class BoxContent extends StatelessWidget {
  final Widget child;
  final String title;

  const BoxContent({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.025,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01,
          horizontal: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
        color: themeColor.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: themeColor.darkText,
            spreadRadius: 0.5,
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                title,
                style: TextStyle(
                  color: themeColor.text,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                ),
              )
            ],
          ),
          child,
        ],
      ),
    );
  }
}
