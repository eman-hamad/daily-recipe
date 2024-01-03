import 'package:daily_recipe/constants/colors.dart';
import 'package:flutter/material.dart';

class RowSubtitleTexts extends StatelessWidget {
  final String txt1;
   final String txt2;
   
  const RowSubtitleTexts({super.key, required this.txt1, required this.txt2});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(txt1 , 
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Spacer(),
      Text(txt2 ,   style: TextStyle(fontSize: 14, color: orange ),),
    ],);
  }
}