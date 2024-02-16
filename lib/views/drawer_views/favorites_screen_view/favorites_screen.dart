import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe_model.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/view_model/provider/recipes.provider.dart';
import 'package:daily_recipe/views/components/search_bar_widet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home_screen_view/home_screen_components/recommended_recipe_widget.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
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
                "Favorites",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
              ),
               Consumer<RecipesProvider>(
                        builder: (ctx, adProvider, _) => SearchBarWidget(
                            searchController: searchController,
                            change: () {
                              // var _Provider.of<RecipesProvider>(context, listen: false).filteredList = [];

                              Provider.of<RecipesProvider>(context,
                                      listen: false)
                                  .filteredRecipes
                                  .clear();
                              if (searchController.text.isEmpty) {
                                //  setState(() {});
                                return;
                              }

                              adProvider.recipesList!.forEach((recipe) {
                                if (recipe.title!.toLowerCase().contains(
                                        searchController.text.toLowerCase()) ||
                                    recipe.description!.toLowerCase().contains(
                                        searchController.text.toLowerCase()) ||
                                    recipe.meal_type!.toLowerCase().contains(
                                        searchController.text.toLowerCase()) ||
                                    recipe.calories
                                        .toString()
                                        .contains(searchController.text) ||
                                    recipe.serving
                                        .toString()
                                        .contains(searchController.text) ||
                                    recipe.rating
                                        .toString()
                                        .contains(searchController.text)) {
                                  adProvider.filteredRecipes.add(recipe);
                                  // imgPosition = 0;
                                 // adProvider.rebuild();
// setState(() {
//  imgPosition = 0;
// });
                                  print("adProvider.filteredRecipes");
                                  print(adProvider
                                      .filteredRecipes); //  adProvider.recipesList =
                                  //   Provider.of<RecipesProvider>(context, listen: false).filteredList;
                                  //  print( "adProvider.recipesList");
                                  //  var x = adProvider.filteredRecipes;
                                  //                                   print(adProvider.filteredRecipes);
                                }
                                //  print( "adProvider.recipesListttt");
                                //   var x = adProvider.filteredRecipes;
                                //                                   print( adProvider.filteredRecipes);
                                // print("Provider.of<RecipesProvider>(context, listen: false).filteredList");
                                // print(Provider.of<RecipesProvider>(context, listen: false).filteredList);
                              });

                              //  setState(() {});
                            })),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recipes')
                      .where("favorite_users_ids",
                          arrayContains: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } 
                    // else if (searchController.text.isNotEmpty && ){

                    // }
                    
                    else {
                      if (snapshots.hasError) {
                        return const Text('ERROR WHEN GET DATA');
                      } else {
                        if (snapshots.hasData) {
                          List<Recipe> recipesList = 
                          // searchController.text.isNotEmpty && 
                          
                          snapshots.data?.docs
                                  .map((e) => Recipe.fromJson(e.data(), e.id))
                                  .toList() ??
                              [];
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                shrinkWrap: true,
                                // scrollDirection: Axis.vertical,
                                itemCount: 
                                // searchController.text.isNotEmpty && 

                                recipesList.length,
                                itemBuilder: (ctx, index) =>
                                    RecommendedRecipeWidget(
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
            ],
          ),
        ),
      ),
    );

    //   SingleChildScrollView(
    // child: Padding(
    //     padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           // const Text(
    //           //   "Favorites",
    //           //   style:
    //           //       TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    //           // ),
    //           // SearchBarWidget(),
    //           FutureBuilder(
    //               future: FirebaseFirestore.instance
    //                   .collection('recipes')
    //                   .get(),
    //               builder: (ctx, snapShot) {
    //                 if (snapShot.connectionState ==
    //                     ConnectionState.waiting) {
    //                   return const CircularProgressIndicator();
    //                 } else {
    //                   if (snapShot.hasError) {
    //                     return const Text('error in get data');
    //                   } else {
    //                     if (snapShot.hasData) {
    //                       if (snapShot.data?.docs.isNotEmpty ?? false) {
    //                         var recipesList = List<Recipe>.from(snapShot
    //                                 .data?.docs
    //                                 .map((e) => Recipe.fromJson(
    //                                     e.data(), e.id)) ??
    //                             []);

    //                         return SizedBox(
    //                           height: MediaQuery.of(context).size.height,
    //                           child: ListView.builder(
    //                               shrinkWrap: true,
    //                               // scrollDirection: Axis.vertical,
    //                               itemCount: recipesList.length,
    //                               itemBuilder: (ctx, index) =>
    //                                   RecommendedRecipeWidget(
    //                                     rate:  5.4,
    //                                     // jsonEncode(
    //                                     //     recipesList[index].rating),

    //                                     calories: jsonEncode(
    //                                         recipesList[index].calories),

    //                                     mealType: jsonEncode(
    //                                         recipesList[index].meal_type),

    //                                     serving: jsonEncode(
    //                                         recipesList[index].serving),

    //                                     img: Uri.encodeFull(
    //                                         '${recipesList[index].image}'),

    //                                     title: jsonEncode(
    //                                             recipesList[index]
    //                                                 .title) ??
    //                                         'no title found',

    //                                     prepTime: jsonEncode(
    //                                         recipesList[index].prep_time),

    //                                     // recommendedImg:
    //                                     // ImagePath.recommendedImages.elementAt(index),
    //                                   )),
    //                         );

    //                         // ListTile(
    //                         //       title: Text(
    //                         //           recipesList[index].title ??
    //                         //               'no title found'),
    //                         //     ))

    //                         // logic
    //                       } else {
    //                         return const Text('No Data Found');
    //                       }
    //                     } else {
    //                       return const Text('No Data Found');
    //                     }
    //                   }
    //                 }

    //                 // Consumer<MealProvider>(
    //                 //   builder: (ctx, adProvider, _) => adProvider.adsList == null
    //                 //       ? const CircularProgressIndicator()
    //                 //       : (adProvider.adsList?.isEmpty ?? false)
    //                 //           ? const Text('No Data Found')
    //                 //           : Container(
    //                 //               height: 333,
    //                 //               // color: orange,
    //                 //               child: ListView.builder(
    //                 //                 itemCount: adProvider.adsList!.length,
    //                 //                 // ImagePath.recommendedImages.length,
    //                 //                 // physics:ScrollPhysics(parent: ) ,
    //                 //                 itemBuilder: (context, index) {
    //                 //                   return ReciepeCardItem(
    //                 //                     calories: adProvider.adsList!
    //                 //                         .elementAt(index)
    //                 //                         .calories
    //                 //                         .toString(),
    //                 //                     mealType: adProvider.adsList!
    //                 //                         .elementAt(index)
    //                 //                         .meal_type!,
    //                 //                     serving: adProvider.adsList!
    //                 //                         .elementAt(index)
    //                 //                         .serving
    //                 //                         .toString(),
    //                 //                     recommendedImg:
    //                 //                         adProvider.adsList!.elementAt(index).image!,
    //                 //                     title:
    //                 //                         adProvider.adsList!.elementAt(index).title!,

    //                 //                     isTodayRecipe: false,
    //                 //                     prepTime: adProvider.adsList!
    //                 //                         .elementAt(index)
    //                 //                         .prep_time
    //                 //                         .toString(),
    //                 //                     // recommendedImg:
    //                 //                     // ImagePath.recommendedImages.elementAt(index),
    //                 //                   );
    //                 //                 },
    //                 //               )),
    //                 // ),
    //                 })
    //           ])),
    // ));
  }
}
