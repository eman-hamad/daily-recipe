import 'package:daily_recipe/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/images.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          //  width: double.infinity,
          decoration: BoxDecoration(
            color: llightGrey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
              decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: ligthGrey),

            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide( width: 1, color:  Colors.red),
            // ),
            hintText: "Search for recipes",

            hintStyle: TextStyle(color: ligthGrey),
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(width: 1, color:  ligthGrey),
            // ),
          )),
        ),
        Container(
            //width: 5,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ImageIcon(
              AssetImage(
                ImagePath.filterIcon,
              ),
              size: 17,
            )),
      ],
    );
  }
}
