import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/views/all_recipes_screen_view/all_recipes_widget.dart';
import 'package:daily_recipe/views/components/search_bar_widet.dart';
import 'package:daily_recipe/views/home_screen_view/home_screen_components/today_recipe_widget.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/provider/recipes.provider.dart';

class AllRecipesScreen extends StatefulWidget {
  const AllRecipesScreen({super.key});

  @override
  State<AllRecipesScreen> createState() => _AllRecipesScreenState();
}

class _AllRecipesScreenState extends State<AllRecipesScreen> {

  late TextEditingController searchController;

  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).getRecipes();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "All Recipes  ",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w400),
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
                                  adProvider.rebuild();
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
                      Consumer<RecipesProvider>(
                          builder: (ctx, recipesProvider, _) => recipesProvider
                                      .recipesList ==
                                  null
                              ? const CircularProgressIndicator()
                              : (recipesProvider.recipesList!.isEmpty 
                              
                              ||
                                        (recipesProvider.filteredRecipes.isEmpty &&
                                            searchController.text.isNotEmpty)
                              
                              
                              ?? false)
                                  ? const Center(
                                    child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text('No Data Found'),
                                  ))
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: FlexibleGridView(
                                        axisCount:
                                            GridLayoutEnum.twoElementsInRow,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        children: 

                                         searchController.text.isNotEmpty
                                        ? recipesProvider.filteredRecipes.map((e) => 
                                         AllRecipesItem(recipe: e))
                                            .toList()
                                            :

                                        recipesProvider.recipesList!
                                            .map((e) =>
                                                AllRecipesItem(recipe: e))
                                            .toList(),
                                      ),
                                    )),
                    ]))));
  }
}
