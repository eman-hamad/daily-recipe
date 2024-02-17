import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe_model.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/view_model/provider/recipes.provider.dart';
import 'package:daily_recipe/views/components/search_bar_widet.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

                        Provider.of<RecipesProvider>(context, listen: false)
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
                          }
                        });
                      })),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recipes')
                      .where("favorite_users_ids",
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
                          List<Recipe> recipesList =
                              // searchController.text.isNotEmpty &&

                              snapshots.data?.docs
                                      .map((e) =>
                                          Recipe.fromJson(e.data(), e.id))
                                      .toList() ??
                                  [];
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    // searchController.text.isNotEmpty &&

                                    recipesList.length,
                                itemBuilder: (ctx, index) =>
                                    RecommendedRecipeWidget(
                                      recipe: recipesList[index],
                                    )),
                          );
                        } else {
                          return const Center(child: Text('No Data Found'));
                        }
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
