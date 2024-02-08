import 'package:daily_recipe/views/components/star_widget.dart';
import 'package:daily_recipe/views/details_screen_view/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../models/recipe_model.dart';
import '../../../view_model/provider/recipes.provider.dart';

class TodayRecipeWidget extends StatelessWidget {
  // String mealType;
  // String title;
  // String calories;
  // String serving;
  // num? rate;
  // String? img;
  // String prepTime;

  final Recipe? recipe;
  TodayRecipeWidget(
      {super.key,
      // required this.img,
      // required this.mealType,
      // required this.title,
      // required this.calories,
      // required this.serving,
      // required this.prepTime,
      // required this.rate,
      required this.recipe});

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
      child: Card(
        elevation: 2,
        color: llightGrey,
        child: Container(
            width: 200,
            // height: 250,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      
            // width: MediaQuery.of(context).size.width,
            // margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(2)),
            child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                child: Column(children: [
                  // Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             margin:
                  //                 const EdgeInsets.symmetric(horizontal: 5.0),
                  //             decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                     fit: BoxFit.fitWidth,
                  //                     image: NetworkImage(todayImg!))),
                  //           ),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: ImageIcon(
                  //     AssetImage(
                  //       ImagePath.likeIcon,
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //     alignment: Alignment.topRight,
                  //     child: Image.network(
                  //       todayImg!,
                  //       height: 70,
                  //       fit: BoxFit.fitHeight,
                  //     )
      
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
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Icon(
                          //     Icons.favorite_outline,
                          //     color: ligthGrey,
                          //     // size: 30,
                          //   ),
                          // ),
                          //]),
                        ),
                        Transform.translate(
                            offset: const Offset(0, 0),
                            // offset: const Offset(20, 0),
                            child: Image.network(
                             recipe!. image!,
                              height: 70,
                              width: 90,
                              fit: BoxFit.fitWidth,
                            ))
                        //          Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   margin:
                        //       const EdgeInsets.symmetric(horizontal: 5.0),
                        //   decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //           fit: BoxFit.fitWidth,
                        //           image: NetworkImage())),
                        // ),
                        //  Image.asset(
                        //   todayImg!,
                        //
                        // )
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe!.meal_type!,
                        // "Breakfast",
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
                          // "French Toast with Berries",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      RatingBarIndicator(
                        //RatingBar.builder(
                        // ignoreGestures: true,
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
                      // const Row(
                      //   //mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
      
                      //     // StarWidget(),
                      //     // StarWidget(),
                      //     // StarWidget(),
                      //     // StarWidget(),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "${recipe!.calories} Calories",
                        // "120 Calories",
                        style: TextStyle(
                            color: deepOrange,
                            fontSize: 8,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          children: [
                            // ImageIcon(
                            //   AssetImage(
                            //     ImagePath.timeIcon,
                            //   ),
                            //),
      
                            const Icon(
                              Icons.access_time,
                              size: 15,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${recipe!.prep_time} mins",
                                //"15 mins",
                                style: TextStyle(
                                  color: ligthGrey,
                                  fontSize: 12,
                                )),
                            // ImageIcon(
                            //   AssetImage(
                            //     ImagePath.servingIcon,
                            //   ),
                            // ),
      
                            const Spacer(),
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
                        ),
                      )
                    ],
                  ),
                ])
                ///////////////////////
                // : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                //    Image.network(
                //           recommendedImg!,
                //           height: 70,
                //           fit: BoxFit.fitHeight,
                //         ),
                //     // Image.asset(
                //     //   recommendedImg!,
                //     //   height: 70,
                //     //   fit: BoxFit.cover,
                //     // ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           mealType,
                //           // "Breakfast",
                //           style: TextStyle(fontSize: 12, color: deepGreen),
                //         ),
                //          Text(
                //           title,
                //           // "French Toast with Berries",
                //           style: TextStyle(fontSize: 18),
                //         ),
                //         const Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             StarWidget(),
                //             StarWidget(),
                //             StarWidget(),
                //             StarWidget(),
                //             StarWidget(),
                //           ],
                //         ),
                //         Text(
                //           calories,
                //           // "120 Calories",
                //           style: TextStyle(
                //             color: deepOrange,
                //             fontSize: 12,
                //           ),
                //         ),
                //         Row(
                //           children: [
                //             ImageIcon(
                //               AssetImage(
                //                 ImagePath.timeIcon,
                //               ),
                //             ),
                //             Text(
                //               prepTime,
                //               //"15 mins",
                //                 style: TextStyle(
                //                   color: ligthGrey,
                //                   fontSize: 12,
                //                 )),
                //             ImageIcon(
                //               AssetImage(
                //                 ImagePath.servingIcon,
                //               ),
                //             ),
                //             Text(
                //               serving,
                //               //"1 Serving",
                //                 style: TextStyle(
                //                   color: ligthGrey,
                //                   fontSize: 12,
                //                 ))
                //           ],
                //         )
                //       ],
                //     ),
                //   ]),
                )),
      ),
    );
  }
}
