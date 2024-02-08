import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return       Icon(Icons.star_rounded ,
                                    //  fill: ,
                                      color: orange,
                                     // llightGrey
                                      //size: 20,
                                      );
                                   
  }
}