import 'package:daily_recipe/views/components/star_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../models/recipe_model.dart';
import '../../../view_model/provider/recipes.provider.dart';

class AllRecipesItem extends StatelessWidget {
  final Recipe? recipe;
  const AllRecipesItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: llightGrey,
      child: Container(
          width: 200,
          decoration: BoxDecoration(
              // color: Colors.amber,
              borderRadius: BorderRadius.circular(2)),
          child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
              child: Column(children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      ),
                      Transform.translate(
                          offset: const Offset(0, 0),
                          // offset: const Offset(20, 0),
                          child: Image.network(
                            recipe!.image!,
                            height: 70,
                            width: 90,
                            fit: BoxFit.fitWidth,
                          ))
                    ]),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        recipe!.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    RatingBarIndicator(
                      rating: recipe!.rating!.toDouble(),

                      // initialRating: 2,
                      // maxRating: 3,
                      // minRating: 1,
                      direction: Axis.horizontal,
                      // allowHalfRating: true,
                      // updateOnDrag: false,
                      unratedColor: Colors.grey,
                      itemCount: 5,
                      itemSize: 18,
                      itemBuilder: (context, _) => const StarWidget(),
                      // onRatingUpdate: (double value) {},
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "${recipe!.calories} Calories",
                      style: TextStyle(
                          color: deepOrange,
                          fontSize: 9,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
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
                          const Spacer(),
                          const Icon(
                            Icons.room_service_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              "${"${recipe!.serving}Serving".substring(0, 5)}...",
                              style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                // decorationStyle: TextDecorationStyle.dotted,
                                color: ligthGrey,
                                fontSize: 12,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ]))),
    );
  }
}
