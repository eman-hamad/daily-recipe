import 'package:daily_recipe/views/components/star_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../models/recipe_model.dart';
import '../../../view_model/provider/recipes.provider.dart';

class DetailedRecipeItem extends StatelessWidget {
  final Recipe? recipe;
  DetailedRecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 170,
      margin: const EdgeInsets.symmetric(vertical: 3),
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
          color: llightGrey, borderRadius: BorderRadius.circular(18)),
      child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  recipe!.meal_type!,
                  style: TextStyle(
                      fontSize: 13,
                      color: deepGreen,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        recipe!.title!,
                        style: const TextStyle(
                            decorationStyle: TextDecorationStyle.dotted,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                      ),
                      child: GestureDetector(
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
                      ),
                    )
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${recipe!.calories} Calories",
                        style: TextStyle(
                            color: deepOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
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
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${recipe!.prep_time} mins",
                              //"15 mins",
                              style: TextStyle(
                                color: ligthGrey,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.room_service_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${recipe!.serving} Serving",
                              style: TextStyle(
                                color: ligthGrey,
                                fontSize: 12,
                              ))
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.network(
                      recipe!.image!,
                      height: 110,
                      // width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
              ])),
    );
  }
}
