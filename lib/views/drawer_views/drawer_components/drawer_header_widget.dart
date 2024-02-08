import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 10, left: 10,
      bottom: 10),
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Image.asset('./assets/images/profile.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Emma Holmes",
                             style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              "View Profile",
                              style: TextStyle(color: ligthGrey, fontSize: 12),
                            ),
                          ],
                        ),
             
                     
                        Align(
                          alignment: Alignment.topRight,
                          child: ImageIcon(
                            AssetImage(
                              ImagePath.notificationIcon,
                            ),
                          ),
                        )
                      ],
                    ),
    );
  }
}