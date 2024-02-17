import 'package:daily_recipe/constants/colors.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  // String img;
  String txt;
  Widget iconWidget;
  Function() press;
  DrawerItemWidget(
      {super.key,
      // required this.img,
      required this.press,
      required this.txt,
      required this.iconWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: iconWidget,
        title: Text(
          txt,
          style: TextStyle(
              color: ligthGrey, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        onTap: press);
  }
}
