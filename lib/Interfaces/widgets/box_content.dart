import 'package:financial_tracker/Commons/themes/colors.dart';
import 'package:flutter/cupertino.dart';

class BoxContent extends StatelessWidget {
  final Widget child;

  const BoxContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.025,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.02,
          horizontal: MediaQuery.of(context).size.height * 0.02),
      decoration: BoxDecoration(
        color: themeColor.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: themeColor.secondary,
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 1)),
        ],
      ),
      child: child,
    );
  }
}
