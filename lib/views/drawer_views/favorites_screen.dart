import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/recipe_model.dart';
import '../../utils/images.dart';
import '../../view_model/provider/meal_provider.dart';
import '../components/recipe_card_item.dart';
import '../components/search_bar_widet.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

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
        body: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Favorites",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              // SearchBarWidget(),
              SizedBox(
                  height: 300,
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('recipes')
                          .get(),
                      builder: (ctx, snapShot) {
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (snapShot.hasError) {
                            return const Text('error in get data');
                          } else {
                            if (snapShot.hasData) {
                              if (snapShot.data?.docs.isNotEmpty ?? false) {
                                var recipesList = List<Recipe>.from(
                                    snapShot.data?.docs.map((e) =>
                                            Recipe.fromJson(e.data(), e.id)) ??
                                        []);

                                return ListView.builder(
                                    shrinkWrap: true,
                                    // scrollDirection: Axis.vertical,
                                    itemCount: recipesList.length,
                                    itemBuilder: (ctx, index) =>
                                        ReciepeCardItem(
                                          calories: jsonEncode(
                                              recipesList[index].calories),

                                          mealType: jsonEncode(
                                              recipesList[index].meal_type),

                                          serving: jsonEncode(
                                              recipesList[index].serving),

                                          recommendedImg: jsonEncode(
                                              recipesList[index]
                                                  .image!
                                                  .replaceAll('"', "")),

                                          title: jsonEncode(
                                                  recipesList[index].title) ??
                                              'no title found',

                                          isTodayRecipe: false,
                                          prepTime: jsonEncode(
                                              recipesList[index].prep_time),

                                          // recommendedImg:
                                          // ImagePath.recommendedImages.elementAt(index),
                                        ));

                                // ListTile(
                                //       title: Text(
                                //           recipesList[index].title ??
                                //               'no title found'),
                                //     ))

                                // logic
                              } else {
                                return const Text('No Data Found');
                              }
                            } else {
                              return const Text('No Data Found');
                            }
                          }
                        }

                        // Consumer<MealProvider>(
                        //   builder: (ctx, adProvider, _) => adProvider.adsList == null
                        //       ? const CircularProgressIndicator()
                        //       : (adProvider.adsList?.isEmpty ?? false)
                        //           ? const Text('No Data Found')
                        //           : Container(
                        //               height: 333,
                        //               // color: orange,
                        //               child: ListView.builder(
                        //                 itemCount: adProvider.adsList!.length,
                        //                 // ImagePath.recommendedImages.length,
                        //                 // physics:ScrollPhysics(parent: ) ,
                        //                 itemBuilder: (context, index) {
                        //                   return ReciepeCardItem(
                        //                     calories: adProvider.adsList!
                        //                         .elementAt(index)
                        //                         .calories
                        //                         .toString(),
                        //                     mealType: adProvider.adsList!
                        //                         .elementAt(index)
                        //                         .meal_type!,
                        //                     serving: adProvider.adsList!
                        //                         .elementAt(index)
                        //                         .serving
                        //                         .toString(),
                        //                     recommendedImg:
                        //                         adProvider.adsList!.elementAt(index).image!,
                        //                     title:
                        //                         adProvider.adsList!.elementAt(index).title!,

                        //                     isTodayRecipe: false,
                        //                     prepTime: adProvider.adsList!
                        //                         .elementAt(index)
                        //                         .prep_time
                        //                         .toString(),
                        //                     // recommendedImg:
                        //                     // ImagePath.recommendedImages.elementAt(index),
                        //                   );
                        //                 },
                        //               )),
                        // ),
                      }))
            ])));
  }
}
