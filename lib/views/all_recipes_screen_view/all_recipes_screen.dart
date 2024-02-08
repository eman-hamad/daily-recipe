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
  @override
  void initState() {
    Provider.of<RecipesProvider>(context, listen: false).getRecipes();
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
                      const SearchBarWidget(),
                      Consumer<RecipesProvider>(
                          builder: (ctx, recipesProvider, _) => recipesProvider
                                      .recipesList ==
                                  null
                              ? const CircularProgressIndicator()
                              : (recipesProvider.recipesList?.isEmpty ?? false)
                                  ? const Text('No Data Found')
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: FlexibleGridView(
                                        axisCount:
                                            GridLayoutEnum.twoElementsInRow,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        children: recipesProvider.recipesList!
                                            .map((e) =>
                                                AllRecipesItem(recipe: e))
                                            .toList(),
                                      ),
                                    )),
                    ]))));
  }
}
