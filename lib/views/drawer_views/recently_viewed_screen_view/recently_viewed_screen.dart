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

                    // SearchBarWidget(),
                     StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recipes')
                      .where("recently_viewd_users_ids",
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshots.hasError) {
                        return const Text('ERROR WHEN GET DATA');
                      } else {
                        if (snapshots.hasData) {
                          List<Recipe> recipesList = snapshots.data?.docs
                                  .map((e) => Recipe.fromJson(e.data(), e.id))
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
                                      // rate:  5.4,
                                      // // jsonEncode(
                                      // //     recipesList[index].rating),

                                      // calories: jsonEncode(
                                      //     recipesList[index].calories),

                                      // mealType: jsonEncode(
                                      //     recipesList[index].meal_type),

                                      // serving: jsonEncode(
                                      //     recipesList[index].serving),

                                      // img: Uri.encodeFull(
                                      //     '${recipesList[index].image}'),

                                      // title: jsonEncode(
                                      //         recipesList[index]
                                      //             .title) ??
                                      //     'no title found',

                                      // prepTime: jsonEncode(
                                      //     recipesList[index].prep_time),

                                      // recommendedImg:
                                      // ImagePath.recommendedImages.elementAt(index),
                                    )),
                          );

                          // ListTile(
                          //       title: Text(
                          //           recipesList[index].title ??
                          //               'no title found'),
                          //     ))

                          // logic
                        } else {
                          return const Text('No Data Found');
                        }

                        // // grid
                        // FlexibleGridView(
                        //   axisCount: GridLayoutEnum.twoElementsInRow,
                        //   crossAxisSpacing: 8,
                        //   mainAxisSpacing: 8,
                        //   children: recipesList
                        //       .map((e) => RecommendedRecipeWidget(
                        //             recipe: e,
                        //             rate: e.rating,
                        //             // jsonEncode(
                        //             //     recipesList[index].rating),

                        //             calories: e.calories.toString(),
                        //             // jsonEncode(
                        //             //     e.calories),

                        //             mealType: e.meal_type!,
                        //             // jsonEncode(
                        //             //     e.meal_type),

                        //             serving: jsonEncode(e.serving),

                        //             img: Uri.encodeFull('${e.image}'),

                        //             title: jsonEncode(e.title) ?? 'no title found',

                        //             prepTime: jsonEncode(e.prep_time),

                        //             // recommendedImg:
                        //             // ImagePath.recommendedImages.elementAt(index),
                        //           ))
                        //       .toList(),
                        // );
                        //   } else {
                        //     return const Text('No Data Found');
                        //   }
                        // }
                      }
                    }
                  }),
                    // FutureBuilder(
                    //     future: FirebaseFirestore.instance
                    //         .collection('recipes')
                    //        .where("recently_viewd_users_ids",
                    //       arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    //   .get(),
                 
                    //     builder: (ctx, snapShot) {
                    //       if (snapShot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const CircularProgressIndicator();
                    //       } else {
                    //         if (snapShot.hasError) {
                    //           return const Text('error in get data');
                    //         } else {
                    //           if (snapShot.hasData) {
                    //             if (snapShot.data?.docs.isNotEmpty ?? false) {
                    //               var recipesList = List<Recipe>.from(snapShot
                    //                       .data?.docs
                    //                       .map((e) => Recipe.fromJson(
                    //                           e.data(), e.id)) ??
                    //                   []);

                    //               return SizedBox(
                    //                 height: MediaQuery.of(context).size.height,
                    //                 child: ListView.builder(
                    //                     shrinkWrap: true,
                    //                     // scrollDirection: Axis.vertical,
                    //                     itemCount: recipesList.length,
                    //                     itemBuilder: (ctx, index) =>
                    //                         RecentlyViewedItem(
                    //                           recipe:
                    //                               recipesList.elementAt(index),
                    //                         )),
                    //               );

                    //               // ListTile(
                    //               //       title: Text(
                    //               //           recipesList[index].title ??
                    //               //               'no title found'),
                    //               //     ))

                    //               // logic
                    //             } else {
                    //               return const Text('No Data Found');
                    //             }
                    //           } else {
                    //             return const Text('No Data Found');
                    //           }
                    //         }
                    //       }

                    //       // Consumer<MealProvider>(
                    //       //   builder: (ctx, adProvider, _) => adProvider.adsList == null
                    //       //       ? const CircularProgressIndicator()
                    //       //       : (adProvider.adsList?.isEmpty ?? false)
                    //       //           ? const Text('No Data Found')
                    //       //           : Container(
                    //       //               height: 333,
                    //       //               // color: orange,
                    //       //               child: ListView.builder(
                    //       //                 itemCount: adProvider.adsList!.length,
                    //       //                 // ImagePath.recommendedImages.length,
                    //       //                 // physics:ScrollPhysics(parent: ) ,
                    //       //                 itemBuilder: (context, index) {
                    //       //                   return ReciepeCardItem(
                    //       //                     calories: adProvider.adsList!
                    //       //                         .elementAt(index)
                    //       //                         .calories
                    //       //                         .toString(),
                    //       //                     mealType: adProvider.adsList!
                    //       //                         .elementAt(index)
                    //       //                         .meal_type!,
                    //       //                     serving: adProvider.adsList!
                    //       //                         .elementAt(index)
                    //       //                         .serving
                    //       //                         .toString(),
                    //       //                     recommendedImg:
                    //       //                         adProvider.adsList!.elementAt(index).image!,
                    //       //                     title:
                    //       //                         adProvider.adsList!.elementAt(index).title!,

                    //       //                     isTodayRecipe: false,
                    //       //                     prepTime: adProvider.adsList!
                    //       //                         .elementAt(index)
                    //       //                         .prep_time
                    //       //                         .toString(),
                    //       //                     // recommendedImg:
                    //       //                     // ImagePath.recommendedImages.elementAt(index),
                    //       //                   );
                    //       //                 },
                    //       //               )),
                    //       // ),
                    //     })
                  ])),
        ));
  }
}
