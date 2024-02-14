import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/ingredients.model.dart';
import 'package:daily_recipe/models/recipe_model.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/provider/recipes.provider.dart';
import 'detailed_recipe_widget.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailsScreen({required this.recipe, super.key});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false)
        .addRecipeToUserRecentlyViewed(widget.recipe.docId!);
    super.initState();
  }

  bool get isInList => (widget.recipe.favorite_users_ids
          ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
      false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // Expanded(
                            // flex: 1,
                           // child:
                             DetailedRecipeItem(recipe: widget.recipe),
                             //),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Ingredients",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ),
                          // ListTile(
                          //   subtitle:
                          ///////////////
                           Expanded(
                            flex: 1,
                            child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('ingredients')
                                    .where('users_ids',
                                        arrayContains: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .get(),
                                builder: (context, snapShot) {
                                  if (snapShot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else {
                                    var userIngredients = List<Ingredient>.from(
                                        snapShot.data!.docs
                                            .map((e) => Ingredient.fromJson(
                                                e.data(), e.id))
                                            .toList());
                            
                                    var userIngredientsTitles = userIngredients
                                        .map((e) => e.name)
                                        .toList();
                                    Widget checkIngredientWidget(
                                        String recipeIngredient) {
                                      bool isExsist = false;
                                      for (var userIngredientsTitle
                                          in userIngredientsTitles) {
                                        if (recipeIngredient
                                            .contains(userIngredientsTitle!)) {
                                          isExsist = true;
                                          break;
                                        } else {
                                          isExsist = false;
                                        }
                                      }
                            
                                      if (isExsist) {
                                        return const Icon(Icons.check , color: Colors.green,);
                                      } else {
                                        return const Icon(Icons.close , color: Colors.red,);
                                      }
                                    }
                            
                                    return SizedBox(
                                    // height: 200,
                                      child: ListView(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: 
                                        widget.recipe.ingredients
                                                ?.map((e) => Row(
                                                  crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            //   mainAxisAlignment:
                                            // MainAxisAlignment.start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            e,
                                                            //maxLines: 1,
                                                          ),
                                                        ),
                                                        // Spacer(),
                                                        checkIngredientWidget(e)
                                                      ],
                                                    ))
                                                .toList() ??
                                            [],
                                      ),
                                    );
                                  }
                                }),
                          ),
                          //////////////////////////////////////
                          // title: Text(widget.recipe.title ?? 'No Title'),
                          // trailing: InkWell(
                          //     onTap: () {
                          //       Provider.of<RecipesProvider>(context, listen: false)
                          //           .addRecipeToUserFavourite(widget.recipe.docId!, !isInList);

                          //       if (isInList) {
                          //         widget.recipe.favorite_users_ids
                          //             ?.remove(FirebaseAuth.instance.currentUser?.uid);
                          //       } else {
                          //         widget.recipe.favorite_users_ids
                          //             ?.add(FirebaseAuth.instance.currentUser!.uid);
                          //       }

                          //       setState(() {});
                          //     },
                          //     child: isInList
                          //         ? const Icon(
                          //             Icons.favorite_border_rounded,
                          //             size: 30,
                          //             color: Colors.red,
                          //           )
                          //         : const Icon(
                          //             Icons.favorite_rounded,
                          //             size: 30,
                          //             color: Colors.grey,
                          //           ))
                          // ),
// SizedBox(
//   height: 20,
// ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Directions",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ),
                          // ListTile(
                          //   subtitle:
                          //  SizedBox(
                          //   height: 150,
                          //    child: ListView.builder(

                          //     itemCount: widget.recipe.directions!.length,

                          //     itemBuilder: (ctx , index){
                          //       var itemKey =widget.recipe.directions!.entries.toList();

                          //       var itemValue =widget.recipe.directions!.values.toList();
                          //       print("itemKey");
                          //        print(itemKey[index].key.toString());
                          //       // print(itemValue);
                          //       return Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,

                          //         children: [

                          //           Text(itemKey[index].key.toString() + ":" , style: TextStyle(fontWeight: FontWeight.bold),),
                          //           Text(itemValue[index].toString()),
                          //         ],
                          //       );
                          //     }),
                          //        )
                          //       // ),
                          //     ],
                          //   ),
                          // ),

                          // for (var entry in widget.recipe.directions!.entries)
                          //   Text(entry.key.toString())

                          //  SizedBox(
                          //   // height: 50,
                          //    child: ListView(
                          //           children:
                          //             (widget.recipe.directions!)
                          //               .entries
                          //               .map(( mapEntry) {
                          //                 return ListTile(
                          //    title: Text(mapEntry.key.toString()),
                          //    trailing: Text(mapEntry.value.toString()));
                          //           }).toList(),
                          //         ),
                          //  )
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              // height: 80,
                              child: ListView(
                                  children: widget.recipe.directions!.entries
                                      .map((mapEntry) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${mapEntry.key.toString()}" " :",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(mapEntry.value.toString()),
                                  ],
                                );
                              }).toList()),
                            ),
                          ),
                        ])))));
  }
}
