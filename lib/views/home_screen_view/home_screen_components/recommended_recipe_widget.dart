import 'package:daily_recipe/views/components/star_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../models/recipe_model.dart';
import '../../../view_model/provider/recipes.provider.dart';
import '../../details_screen_view/details_screen.dart';

class RecommendedRecipeWidget extends StatelessWidget {
  final Recipe? recipe;
  RecommendedRecipeWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeDetailsScreen(
                      recipe: recipe!,
                    )));
      },
      child: Material(
          elevation: 2,
          child: Container(
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 6),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: llightGrey, borderRadius: BorderRadius.circular(18)),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 12),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        recipe!.image!,
                        height: 120,
                        width: 70,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe!.meal_type!,
                            style: TextStyle(
                                fontSize: 13,
                                color: deepGreen,
                                fontWeight: FontWeight.w400),
                          ),
                          Flexible(
                            child: Text(
                              recipe!.title!.length > 23
                                  ? recipe!.title!.substring(0, 23) + "..."
                                  : recipe!.title!,
                              style: const TextStyle(
                                  decorationStyle: TextDecorationStyle.dotted,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          //  const SizedBox(
                          //   height: 3,
                          // ),
                          Row(children: [
                            RatingBarIndicator(
                              // ignoreGestures: true,
                              rating: recipe!.rating! as double,
                              // initialRating: 4,
                              // minRating: 1,
                              direction: Axis.horizontal,
                              // allowHalfRating: true,
                              // updateOnDrag: false,
                              unratedColor: Colors.grey,
                              itemCount: 5,
                              itemSize: 18,
                              itemBuilder: (context, _) => const StarWidget(),
                              //  onRatingUpdate: (double value) {},
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${recipe!.calories} Calories",
                              style: TextStyle(
                                  color: deepOrange,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),

                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 15,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("${recipe!.prep_time} mins",
                                  style: TextStyle(
                                    color: ligthGrey,
                                    fontSize: 12,
                                  )),
                              const SizedBox(
                                width: 32,
                              ),
                              const Icon(
                                Icons.room_service_outlined,
                                size: 15,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("${recipe!.serving} Serving",
                                  style: TextStyle(
                                    color: ligthGrey,
                                    fontSize: 12,
                                  ))
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Provider.of<RecipesProvider>(context, listen: false)
                              .addRecipeToUserFavourite(
                                  recipe!.docId!,
                                  !(recipe?.favorite_users_ids?.contains(
                                          FirebaseAuth
                                              .instance.currentUser?.uid) ??
                                      false));
                        },
                        child: (recipe?.favorite_users_ids?.contains(
                                    FirebaseAuth.instance.currentUser?.uid) ??
                                false
                            ? const Icon(
                                Icons.favorite_rounded,
                                size: 30,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_rounded,
                                size: 30,
                                color: ligthGrey,
                              )),
                      )
                    ])),
          )),
    );
  }
}
