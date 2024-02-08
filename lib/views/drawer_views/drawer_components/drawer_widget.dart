

import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:daily_recipe/views/drawer_views/drawer_components/drawer_header_widget.dart';
import 'package:daily_recipe/views/drawer_views/drawer_components/drawer_item._widget.dart';
import 'package:daily_recipe/views/drawer_views/favorites_screen_view/favorites_screen.dart';
import 'package:daily_recipe/views/drawer_views/ingredietnt_screen_view/ingredietnt_screen.dart';
import 'package:daily_recipe/views/drawer_views/recently_viewed_screen_view/recently_viewed_screen.dart';
import 'package:daily_recipe/views/drawer_views/settings_screen_view/settings_screen.dart';

import 'package:daily_recipe/views/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  ZoomDrawerController drawerController;
  Widget minWidget;
  DrawerWidget(
      {super.key, required this.drawerController, required this.minWidget});
// bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuBackgroundColor: Colors.white,
      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      disableDragGesture: true,
      mainScreenTapClose: true,
      controller: drawerController,
      drawerShadowsBackgroundColor: Colors.grey,
      menuScreen: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Expanded(
              //   flex: 1,
              //   child:DrawerHeaderWidget()
              // ),
              const DrawerHeaderWidget(),
              const SizedBox(
                height: 40,
              ),
                GestureDetector(
      onTap: () {
         Provider.of<AppAuthProvider>(context, listen: false).rebuild();
        // setState(() {
        //   isPressed = true;
        // });
        print("isPressed");
        print(Provider.of<AppAuthProvider>(context, listen: false).isPressed);
      // d();
      },
                child: DrawerItemWidget(
                  txt: "Home",
                  iconWidget: Icon(
                    Icons.home,
                    color:Provider.of<AppAuthProvider>(context, listen: false).isPressed? orange: ligthGrey,
                  ),
                  press: () {
                    //drawerController.toggle?.call();
                    // drawerController.pop(context);
                    // study this
                  },
                ),
              ),

              DrawerItemWidget(
                txt: "Favorites",
                iconWidget: Icon(
                  Icons.favorite_border,
                  color: ligthGrey,
                ),
                press: () {
                  drawerController.close?.call();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FavoritesScreen()));
                },
              ),
              DrawerItemWidget(
                iconWidget: Icon(
                  Icons.play_circle_outline,
                  color: ligthGrey,
                ),
                press: () {
                  drawerController.close?.call();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RecentlyViewedScreen()));
                },
                txt: "Recently Viewed",
              ),
              DrawerItemWidget(
                iconWidget: Icon(
                  Icons.filter_alt_off_outlined,
                  color: ligthGrey,
                ),
                press: () {
                  drawerController.close?.call();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FilterScreen()));
                },
                txt: "Filter",
              ),
              DrawerItemWidget(
                iconWidget: Icon(
                  Icons.food_bank,
                  color: ligthGrey,
                ),
                press: () {
                  drawerController.close?.call();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => IngredientScreen()));
                },
                txt: "Ingredients",
              ),
              DrawerItemWidget(
                iconWidget: Icon(
                  Icons.settings,
                  color: ligthGrey,
                ),
                press: () {
                  drawerController.close?.call();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SettingsScreen()));
                  // Navigator.pop(context);
                },
                txt: "Settings",
              ),
              DrawerItemWidget(
                iconWidget: Icon(Icons.logout, color: ligthGrey),
                press: () {
                  Provider.of<AppAuthProvider>(context, listen: false)
                      .signOut(context);
                },
                txt: "Sign Out",
              ),
            ],
          ),
        ),
      ),
      mainScreen: minWidget,
    );

    //  ListView(
    //   // Important: Remove any padding from the ListView.
    //   padding: EdgeInsets.zero,
    //   children: [
    //     DrawerHeader(
    //       // decoration: const BoxDecoration(
    //       //   color: Colors.blue,
    //       // ),
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 10),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             CircleAvatar(
    //               child: Image.asset('./assets/images/profile.png'),
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   "Emma Holmes",
    //                   style: TextStyle(fontSize: 20),
    //                 ),
    //                 Text(
    //                   "View Profile",
    //                   style: TextStyle(color: ligthGrey, fontSize: 12),
    //                 ),
    //               ],
    //             ),
    //             ImageIcon(
    //               AssetImage(
    //                 ImagePath.notificationIcon,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),

    //     ListTile(
    //       leading: const Icon(
    //         Icons.favorite,
    //         color: Color.fromARGB(255, 120, 78, 78),
    //         fill: 0,
    //       ),
    //       title: const Text('Page 1'),
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     DrawerItemWidget(
    //       img: ImagePath.homeIcon,
    //       press: () {
    //         Navigator.push(context,
    //                   MaterialPageRoute(builder: (_) => IngredientScreen()));
    //       },
    //       txt: "Home",
    //     ),

    //       DrawerItemWidget(
    //         img: ImagePath.likeIcon,
    //         press: () {
    //            Navigator.push(context,
    //                   MaterialPageRoute(builder: (_) => FavoritesScreen()));
    //         },
    //         txt: "Favorites",
    //       ),

    //      DrawerItemWidget(
    //         img: ImagePath.playIcon,
    //         press: () {
    //           Navigator.push(context,
    //                   MaterialPageRoute(builder: (_) => RecentlyViewedScreen()));
    //         },
    //         txt: "Recently Viewed",
    //       ),

    //       DrawerItemWidget(
    //         img: ImagePath.settingsIcon,
    //         press: () {
    //             Navigator.push(context,
    //                   MaterialPageRoute(builder: (_) => SettingsScreen()));
    //          // Navigator.pop(context);
    //         },
    //         txt: "Settings",
    //       ),

    //       DrawerItemWidget(
    //         img: ImagePath.infoIcon,
    //         press: () {
    //           Navigator.pop(context);
    //         },
    //         txt: "About Us",
    //       ),

    //       DrawerItemWidget(
    //         img: ImagePath.homeIcon,
    //         press: () {
    //           Navigator.pop(context);
    //         },
    //         txt: "Help",
    //       ),

    //       DrawerItemWidget(
    //         img: ImagePath.homeIcon,
    //         press: () {
    //           Navigator.pop(context);
    //         },
    //         txt: "Sign Out",
    //       ),
    //   ],
    // );
  }
}
