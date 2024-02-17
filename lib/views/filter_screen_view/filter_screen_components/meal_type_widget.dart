import 'package:daily_recipe/constants/colors.dart';
import 'package:flutter/material.dart';

class MealTypeWidget extends StatelessWidget {
  String txt;
  Function() tap;
  var selectedUserValue;
  MealTypeWidget(
      {super.key,
      required this.txt,
      required this.tap,
      required this.selectedUserValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Chip(
        side: BorderSide(
            color: selectedUserValue['type'] == "$txt" ? orange : simiGrey),
        label: Text(
          txt,
          style: TextStyle(
              color: selectedUserValue['type'] == "$txt" ? orange : deepGrey),
        ),
        backgroundColor:
            selectedUserValue['type'] == "$txt" ? lightOrange : simiGrey,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    );
  }
}
