import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/views/components/recipe_card_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';

import 'package:flutter/material.dart';

import '../../models/recipe_model.dart';


class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites page'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('recipes')
              .where("favourite_users_ids",
                  arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshots.hasError) {
                return const Text('ERROR WHEN GET DATA');
              } else {
                if (snapshots.hasData) {
                  List<Recipe> recipesList = snapshots.data?.docs
                          .map((e) => Recipe.fromJson(e.data(), e.id))
                          .toList() ??
                      [];
                  return FlexibleGridView(
                    axisCount: GridLayoutEnum.twoElementsInRow,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: recipesList
                        .map((e) =>   ReciepeCardItem(
                                          calories: jsonEncode(
                                              e.calories),

                                          mealType: jsonEncode(
                                          e.meal_type),

                                          serving: jsonEncode(
                                          e.serving),

                                          recommendedImg: 
                                        Uri.encodeFull( 
                                              '${e.image}' )
                                                  ,

                                          title: jsonEncode(
                                               e.title),

                                          isTodayRecipe: false,
                                          prepTime: jsonEncode(
                                             e.prep_time),

                                          // recommendedImg:
                                          // ImagePath.recommendedImages.elementAt(index),
                                        ))
                        .toList(),
                  );
                } else {
                  return const Text('No Data Found');
                }
              }
            }
          }),
    );
  }
}