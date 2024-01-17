import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/provider/meal_provider.dart';
import 'components/recipe_card_item.dart';
import 'components/row_subtitle_texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController crslController = CarouselController();
  int imgPosition = 0;

  @override
  void initState()  {
    getMealsData();
    super.initState();
  }
getMealsData() async{
await Provider.of<MealProvider>(context, listen: false).getMeals();
print("00");
print(Provider.of<MealProvider>(context, listen: false).mealsList);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ImageIcon(
            AssetImage(
              ImagePath.menuIcon,
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
          ),
        ],
      ),
      body: Consumer<MealProvider>(
      
          builder: (context, value,child) {
            return value.mealsList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bonjour, Emma",
                                style:
                                    TextStyle(color: ligthGrey, fontSize: 12),
                              ),

                              const Text(
                                "What would you like to cook today?",
                                style: TextStyle(fontSize: 20),
                              ),

                              // SearchBarWidget(),
                            ],
                          ),
                        ),
                        const RowSubtitleTexts(
                          txt1: 'Today\'s Fresh Recipes',
                          txt2: 'See All',
                        ),
                        Expanded(
                          flex: 2,
                          child: Stack(children: [
                            CarouselSlider(
                              carouselController: crslController,
                              options: CarouselOptions(
                                // height: MediaQuery.of(context).size.height / 2,
                                //    height: 296.0
                                //  aspectRatio:1.5,
                                // viewportFraction: 0.65,
                                enlargeFactor: .3,
                                height: 200,
                                viewportFraction: .75,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  imgPosition = index;
                                  setState(() {});
                                },
                              ),
                              items: value.mealsList.map((meal)
                                  // ImagePath.todayImages.map((i)
                                  {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return ReciepeCardItem(
                                      calories: "meal.calories!",
                                      mealType: meal.meal_type!,

                                      serving: "1",
                                      //"meal.serving!",
                                      recommendedImg: meal.image!,
                                      title: meal.title!,
                                      isTodayRecipe: true,
                                      todayImg: meal.image!, prepTime: 'fht',
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
                                icon: Icon(Icons.arrow_forward_ios_outlined,
                                    fill: 1,
                                    size: 30,
                                    color: orange,
                                    weight: 20),
                              ),
                            )
                          ]),
                        ),
                        DotsIndicator(
                          dotsCount: value.mealsList.length,
                          //ImagePath.todayImages.length,
                          position: imgPosition,
                          onTap: (position) async {
                            await crslController.animateToPage(position);
                            imgPosition = position;
                            setState(() {});
                          },
                          decorator: DotsDecorator(
                            activeColor: orange,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        const RowSubtitleTexts(
                          txt1: 'Recommended',
                          txt2: 'See All',
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              // color: orange,
                              child: ListView.builder(
                            itemCount: value.mealsList.length,
                            // ImagePath.recommendedImages.length,
                            // physics:ScrollPhysics(parent: ) ,
                            itemBuilder: (context, index) {
                              return ReciepeCardItem(
                                calories:
                                    "mealsList.elementAt(index).calories!",
                                mealType: "mealsList.elementAt(index).type!",
                                serving: "7",
                                // mealsList.elementAt(index).serving!,
                                recommendedImg:
                                    value.mealsList.elementAt(index).image!,
                                title: value.mealsList.elementAt(index).title!,

                                isTodayRecipe: false, prepTime: 'tr',
                                // recommendedImg:
                                // ImagePath.recommendedImages.elementAt(index),
                              );
                            },
                          )),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
