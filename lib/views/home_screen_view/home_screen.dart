import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/views/drawer_views/drawer_components/drawer_widget.dart';
import 'package:daily_recipe/views/home_screen_view/home_screen_components/recommended_recipe_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import '../../utils/icons.dart';
import '../../view_model/provider/recipes.provider.dart';
import '../components/row_subtitle_texts.dart';
import '../components/search_bar_widet.dart';
import 'home_screen_components/today_recipe_widget.dart';

class HomeScreen extends StatefulWidget {
  final String? name;
  HomeScreen({super.key, this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController crslController = CarouselController();
  late TextEditingController searchController;
  int imgPosition = 0;
  late ZoomDrawerController controller;
  @override
  void initState() {
    init();

    controller = ZoomDrawerController();
    searchController = TextEditingController();
    super.initState();
  }

  init() async {
    await Provider.of<RecipesProvider>(context, listen: false).getRecipes();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return DrawerWidget(
      name: widget.name,
      minWidget: Scaffold(
          key: _key,
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                controller.toggle!();
              },
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    IconPath.menuIcon,
                    height: 32,
                  )),
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
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bonjour, ${widget.name}",
                      style: TextStyle(color: ligthGrey, fontSize: 12),
                    ),
                    const Text(
                      "What would you like to cook today?",
                      style: TextStyle(fontSize: 20),
                    ),
                    Consumer<RecipesProvider>(
                        builder: (ctx, adProvider, _) => SearchBarWidget(
                            searchController: searchController,
                            change: () {
                              Provider.of<RecipesProvider>(context,
                                      listen: false)
                                  .filteredRecipes
                                  .clear();
                              if (searchController.text.isEmpty) {
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
                                  imgPosition = 0;
                                  adProvider.rebuild();
// setState(() {
//  imgPosition = 0;
// });
                                }
                              });
                            })),
                    const RowSubtitleTexts(
                      txt1: 'Today\'s Fresh Recipes',
                      txt2: 'See All',
                    ),
                    Consumer<RecipesProvider>(
                        builder: (ctx, adProvider, _) => adProvider
                                    .recipesList ==
                                null
                            ? const Center(child: CircularProgressIndicator())
                            : (adProvider.recipesList!.isEmpty ||
                                        (adProvider.filteredRecipes.isEmpty &&
                                            searchController.text.isNotEmpty) ??
                                    false)
                                ? const Center(
                                    child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text('No Data Found'),
                                  ))
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        CarouselSlider(
                                          carouselController: crslController,
                                          options: CarouselOptions(
                                            height: 220,
                                            autoPlay: true,
                                            viewportFraction: 0.65,
                                            enlargeStrategy:
                                                CenterPageEnlargeStrategy
                                                    .height,
                                            //  enlargeCenterPage: true,
                                            onPageChanged: (index, reason) {
                                              imgPosition = index;
                                              setState(() {});
                                            },
                                          ),
                                          items: searchController
                                                  .text.isNotEmpty
                                              ? adProvider.filteredRecipes
                                                  .where((element) =>
                                                      element.is_fresh == true)
                                                  .map((ad) {
                                                  return Builder(
                                                    builder:
                                                        (BuildContext context) {
                                                      return TodayRecipeWidget(
                                                        recipe: ad,
                                                      );
                                                    },
                                                  );
                                                }).toList()
                                              : adProvider.recipesList!
                                                  .where((element) =>
                                                      element.is_fresh == true)
                                                  .map((ad) {
                                                  return Builder(
                                                    builder:
                                                        (BuildContext context) {
                                                      return TodayRecipeWidget(
                                                        recipe: ad,
                                                      );
                                                    },
                                                  );
                                                }).toList(),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          heightFactor: 2.5,
                                          child: IconButton(
                                            onPressed: () {
                                              if (adProvider.filteredRecipes
                                                          .length <
                                                      3 &&
                                                  searchController
                                                      .text.isNotEmpty) {
                                              } else {
                                                crslController.previousPage();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios_new_outlined,
                                              size: 30,
                                              color: orange,
                                              weight: 20,
                                              fill: 1,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          heightFactor: 2.5,
                                          child: IconButton(
                                            onPressed: () {
                                              if (adProvider.filteredRecipes
                                                          .length <
                                                      3 &&
                                                  searchController
                                                      .text.isNotEmpty) {
                                              } else {
                                                crslController.nextPage();
                                              }
                                            },
                                            icon: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                fill: 1,
                                                size: 30,
                                                color: orange,
                                                weight: 20),
                                          ),
                                        )
                                      ]),

//                                         (adProvider.filteredRecipes.isEmpty &&
//                                             searchController.text.isNotEmpty)?
// Container()
//                                      :
                                      DotsIndicator(
                                        dotsCount: searchController
                                                    .text.isNotEmpty &&
                                                adProvider
                                                    .filteredRecipes.isNotEmpty
                                            ? adProvider.filteredRecipes
                                                .where((element) =>
                                                    element.is_fresh == true)
                                                .length
                                            : adProvider.recipesList!
                                                .where((element) =>
                                                    element.is_fresh == true)
                                                .length,
                                        position: imgPosition,
                                        onTap: (position) async {
                                          if (adProvider
                                                      .filteredRecipes.length <
                                                  3 &&
                                              searchController
                                                  .text.isNotEmpty) {
                                          } else {
                                            await crslController
                                                .animateToPage(position);
                                            imgPosition = position;
                                          }
                                          setState(() {});
                                        },
                                        decorator: DotsDecorator(
                                          activeColor: orange,
                                          size: const Size.square(9.0),
                                          activeSize: const Size(18.0, 9.0),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                        ),
                                      ),
                                    ],
                                  )),
                    const RowSubtitleTexts(
                      txt1: 'Recommended',
                      txt2: 'See All',
                    ),
                    Expanded(
                      flex: 1,
                      child: Consumer<RecipesProvider>(
                        builder: (ctx, adProvider, _) => adProvider
                                    .recipesList ==
                                null
                            ? const Center(child: CircularProgressIndicator())
                            : (adProvider.recipesList!.isEmpty ||
                                        (adProvider.filteredRecipes.isEmpty &&
                                            searchController.text.isNotEmpty) ??
                                    false)
                                ? const Center(
                                    child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text('No Data Found'),
                                  ))
                                : ListView.builder(
                                    itemCount: searchController.text.isNotEmpty
                                        ? adProvider.filteredRecipes
                                            .where((element) =>
                                                element.is_fresh == false)
                                            .length
                                        : adProvider.recipesList!
                                            .where((element) =>
                                                element.is_fresh == false)
                                            .length,
                                    itemBuilder: (context, index) {
                                      var recipes = searchController
                                              .text.isNotEmpty
                                          ? adProvider.filteredRecipes.where(
                                              (element) =>
                                                  element.is_fresh == false)
                                          : adProvider.recipesList!.where(
                                              (element) =>
                                                  element.is_fresh == false);

                                      return RecommendedRecipeWidget(
                                        recipe: recipes.elementAt(index),
                                      );

                                      // :
                                    },
                                  ),
                      ),
                    ),
                  ]),
            ),
          )),
      drawerController: controller,
    );
  }
}
