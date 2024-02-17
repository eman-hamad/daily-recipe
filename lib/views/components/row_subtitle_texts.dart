import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/views/all_recipes_screen_view/all_recipes_screen.dart';
import 'package:flutter/material.dart';

class RowSubtitleTexts extends StatelessWidget {
  final String txt1;
  final String txt2;

  const RowSubtitleTexts({super.key, required this.txt1, required this.txt2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txt1,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Spacer(),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AllRecipesScreen()));
              },
              child: Text(
                txt2,
                style: TextStyle(fontSize: 14, color: orange),
              )),
        ],
      ),
    );
  }
}
