import 'package:daily_recipe/views/drawer_views/favorites_screen.dart';
import 'package:daily_recipe/views/drawer_views/recently_viewed_screen.dart';
import 'package:daily_recipe/views/drawer_views/settings_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../utils/images.dart';
import '../../drawer_views/ingredietnt_screen.dart';
import 'drawer_item._widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          // decoration: const BoxDecoration(
          //   color: Colors.blue,
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Image.asset('./assets/images/profile.png'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Emma Holmes",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "View Profile",
                      style: TextStyle(color: ligthGrey, fontSize: 12),
                    ),
                  ],
                ),
                ImageIcon(
                  AssetImage(
                    ImagePath.notificationIcon,
                  ),
                )
              ],
            ),
          ),
        ),

        ListTile(
          leading: const Icon(
            Icons.favorite,
            color: Color.fromARGB(255, 120, 78, 78),
            fill: 0,
          ),
          title: const Text('Page 1'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        DrawerItemWidget(
          img: ImagePath.homeIcon,
          press: () {
            Navigator.push(context,
                      MaterialPageRoute(builder: (_) => IngredientScreen()));
          },
          txt: "Home",
        ),

          DrawerItemWidget(
            img: ImagePath.likeIcon,
            press: () {
               Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FavouritesPage()));
            },
            txt: "Favorites",
          ),

         DrawerItemWidget(
            img: ImagePath.playIcon,
            press: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RecentlyViewedScreen()));
            },
            txt: "Recently Viewed",
          ),

          DrawerItemWidget(
            img: ImagePath.settingsIcon,
            press: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SettingsScreen()));
             // Navigator.pop(context);
            },
            txt: "Settings",
          ),

          DrawerItemWidget(
            img: ImagePath.infoIcon,
            press: () {
              Navigator.pop(context);
            },
            txt: "About Us",
          ),

          DrawerItemWidget(
            img: ImagePath.homeIcon,
            press: () {
              Navigator.pop(context);
            },
            txt: "Help",
          ),

          DrawerItemWidget(
            img: ImagePath.homeIcon,
            press: () {
              Navigator.pop(context);
            },
            txt: "Sign Out",
          ),
      ],
    );
  }
}
