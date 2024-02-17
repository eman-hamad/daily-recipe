import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/views/home_screen_view/home_screen_components/recommended_recipe_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/provider/recipes.provider.dart';
import '../components/row_subtitle_texts.dart';

class FilteredScreen extends StatefulWidget {
  String type;
  int serv;
  int time;
  FilteredScreen(
      {super.key, required this.serv, required this.time, required this.type});

  @override
  State<FilteredScreen> createState() => _FilteredScreenState();
}

class _FilteredScreenState extends State<FilteredScreen> {
  @override
  void initState() {
    init();

    super.initState();
  }

  init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .getFilteredResult(widget.type, widget.serv, widget.time);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const RowSubtitleTexts(
                txt1: 'Filtered Recipes',
                txt2: 'See All',
              ),
              Text(
                "Meal Type:  ${widget.type}",
                style:
                    TextStyle(color: deepOrange, fontWeight: FontWeight.bold),
              ),
              Text(
                "Serving:  ${widget.serv}",
                style:
                    TextStyle(color: deepOrange, fontWeight: FontWeight.bold),
              ),
              Text(
                "Preperation Time:  ${widget.time}",
                style:
                    TextStyle(color: deepOrange, fontWeight: FontWeight.bold),
              ),
              Consumer<RecipesProvider>(
                builder: (ctx, adProvider, _) => adProvider.filteredList == null
                    ? const Center(child: CircularProgressIndicator())
                    : (adProvider.filteredList?.isEmpty ?? false)
                        ? const Center(child: Text('No Data Found'))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                itemCount: adProvider.filteredList!.length,
                                // .map((element) =>
                                //     element.is_fresh == false)
                                // .length,
                                // ImagePath.recommendedImages.length,
                                // physics:ScrollPhysics(parent: ) ,
                                itemBuilder: (context, index) {
                                  //  print("object");
                                  //  print(adProvider.adsList!.where((element) =>  element.is_fresh == false ).length);

                                  // var recipes = adProvider.x!.map(
                                  //     (element) );

                                  return RecommendedRecipeWidget(
                                    recipe: adProvider.filteredList!
                                        .elementAt(index),
                                  );
                                },
                              ),
                            ),
                          ),
              ),
            ]),
          ),
        ));
  }
}
