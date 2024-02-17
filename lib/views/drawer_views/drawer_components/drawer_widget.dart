import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:daily_recipe/views/drawer_views/drawer_components/drawer_header_widget.dart';
import 'package:daily_recipe/views/drawer_views/drawer_components/drawer_item._widget.dart';
import 'package:daily_recipe/views/drawer_views/favorites_screen_view/favorites_screen.dart';
import 'package:daily_recipe/views/drawer_views/ingredietnt_screen_view/ingredietnt_screen.dart';
import 'package:daily_recipe/views/drawer_views/recently_viewed_screen_view/recently_viewed_screen.dart';
import 'package:daily_recipe/views/drawer_views/settings_screen_view/settings_screen.dart';
import 'package:daily_recipe/views/filter_screen_view/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  ZoomDrawerController drawerController;
  Widget minWidget;
  final String? name;
  DrawerWidget(
      {super.key,
      required this.drawerController,
      this.name,
      required this.minWidget});
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
              const DrawerHeaderWidget(
                  //name: name,
                  ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<AppAuthProvider>(context, listen: false)
                      .rebuild();

                  // print("isPressed");
                  // print(Provider.of<AppAuthProvider>(context, listen: false)
                  //     .isPressed);
                },
                child: DrawerItemWidget(
                  txt: "Home",
                  iconWidget: Icon(
                    Icons.home,
                    color: Provider.of<AppAuthProvider>(context, listen: false)
                            .isPressed
                        ? orange
                        : ligthGrey,
                  ),
                  press: () {
                    drawerController.toggle?.call();
                    // drawerController.pop(context);
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
  }
}
