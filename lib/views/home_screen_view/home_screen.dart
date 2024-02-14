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
  final String ? name ;
   HomeScreen( {super.key , this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController crslController = CarouselController();
  int imgPosition = 0;
  late ZoomDrawerController controller;
  @override
  void initState() {
    init();
    //getMealsData();
    controller = ZoomDrawerController();
    super.initState();
  }

  init() async {
    await Provider.of<RecipesProvider>(context, listen: false).getRecipes();
  }

  // getMealsData() async {
  //   await Provider.of<MealProvider>(context, listen: false).getMeals();
  // }

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
                //_key.currentState!.openDrawer();
              },
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    IconPath.menuIcon,
                    height: 32,
                  )
                  // ImageIcon(
                  //   AssetImage(
                  //     ImagePath.menuIcon,
                  //   ),
                  // ),
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

                    // const SizedBox(
                    //   height: 12,
                    // ),
                    const SearchBarWidget(),

                    const RowSubtitleTexts(
                      txt1: 'Today\'s Fresh Recipes',
                      txt2: 'See All',
                    ),

                    Consumer<RecipesProvider>(
                        builder: (ctx, adProvider, _) => adProvider.recipesList ==
                                null
                            ? const Center(child: CircularProgressIndicator())
                            : (adProvider.recipesList?.isEmpty ?? false)
                                ? const Text('No Data Found')
                                :
                                // adProvider.adsList.elementAt(index).
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        CarouselSlider(
                                          carouselController: crslController,
                                          options: CarouselOptions(
                                            // height: MediaQuery.of(context).size.height / 2,
                                            //    height: 296.0
                                            //  aspectRatio:1.5,
                                            // viewportFraction: 0.65,
                                            // enlargeFactor: .3,
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
                                          items: adProvider.recipesList!
                                              .where((element) =>
                                                  element.is_fresh == true)
                                              .map((ad)
                                                  // ImagePath.todayImages.map((i)

                                                  {
                                            return Builder(
                                              builder: (BuildContext context) {

                                                    print(ad.title);
                                              print(ad.rating);
                                                return TodayRecipeWidget(
                                                  // rate:ad.rating!,
                                                  //   calories:
                                                  //       ad.calories.toString(),
                                                  //   mealType: ad.meal_type!
                                                  //       .toString(),
                                                  //   serving:
                                                  //       ad.serving!.toString(),
                                                  //   img: ad.image!,
                                                  //   title: ad.title!.toString(),
                                               
                                                  //   prepTime: ad.prep_time
                                                        // .toString(), 
                                                        recipe: ad,);
                                              },
                                            );
                                          }).toList(),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          heightFactor: 2.5,
                                          child: IconButton(
                                            onPressed: () {
                                              crslController.previousPage();
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
                                              crslController.nextPage();
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
                                      DotsIndicator(
                                        dotsCount: adProvider.recipesList!
                                            .where((element) =>
                                                element.is_fresh == true)
                                            .length,
                                        //ImagePath.todayImages.length,
                                        position: imgPosition,
                                        onTap: (position) async {
                                          await crslController
                                              .animateToPage(position);
                                          imgPosition = position;
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
                        builder: (ctx, adProvider, _) => adProvider.recipesList ==
                                null
                            ? const Center(child: CircularProgressIndicator())
                            : (adProvider.recipesList?.isEmpty ?? false)
                                ? const Text('No Data Found')
                                : ListView.builder(
                                    itemCount: adProvider.recipesList!
                                        .where((element) =>
                                            element.is_fresh == false)
                                        .length,
                                    // ImagePath.recommendedImages.length,
                                    // physics:ScrollPhysics(parent: ) ,
                                    itemBuilder: (context, index) {
                                      //  print("object");
                                      //  print(adProvider.adsList!.where((element) =>  element.is_fresh == false ).length);

                                      var recipes = adProvider.recipesList!.where(
                                          (element) =>
                                              element.is_fresh == false);
                                          

                                      return RecommendedRecipeWidget(
                                        recipe:recipes.elementAt(index) ,
                                        // rate: recipes.elementAt(index).rating!,
                                        // calories: recipes
                                        //     .elementAt(index)
                                        //     .calories
                                        //     .toString(),
                                        // mealType:
                                        //     recipes.elementAt(index).meal_type!,
                                        // serving: recipes
                                        //     .elementAt(index)
                                        //     .serving
                                        //     .toString(),
                                        // img: recipes.elementAt(index).image!,
                                        // title: recipes.elementAt(index).title!,

                                        // prepTime: recipes
                                        //     .elementAt(index)
                                        //     .prep_time
                                        //     .toString(),
                                        // // recommendedImg:
                                        // ImagePath.recommendedImages.elementAt(index),
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
