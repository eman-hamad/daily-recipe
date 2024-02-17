import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe_model.dart';
import 'package:daily_recipe/views/drawer_views/recently_viewed_screen_view/recently_viewed_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/images.dart';
import '../../components/search_bar_widet.dart';

class RecentlyViewedScreen extends StatelessWidget {
  RecentlyViewedScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              // _key.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageIcon(
                AssetImage(
                  ImagePath.menuIcon,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageIcon(
                AssetImage(
                  ImagePath.notificationIcon,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recently Viewed",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    SearchBarWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('recipes')
                            .where("recently_viewd_users_ids",
                                arrayContains:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshots) {
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            if (snapshots.hasError) {
                              return const Text('ERROR WHEN GET DATA');
                            } else {
                              if (snapshots.hasData) {
                                List<Recipe> recipesList = snapshots.data?.docs
                                        .map((e) =>
                                            Recipe.fromJson(e.data(), e.id))
                                        .toList() ??
                                    [];
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.vertical,
                                      itemCount: recipesList.length,
                                      itemBuilder: (ctx, index) =>
                                          RecentlyViewedItem(
                                            recipe: recipesList[index],
                                          )),
                                );
                              } else {
                                return const Center(
                                    child: const Center(
                                        child: const Text('No Data Found')));
                              }
                            }
                          }
                        }),
                  ])),
        ));
  }
}
