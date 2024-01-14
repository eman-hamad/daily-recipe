import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/meal.model.dart';


class MealProvider extends ChangeNotifier {
  List<Meal> mealsList = [];

  Future<void> getMeals() async {
    var mealData = await rootBundle.loadString('assets/data/sample.json');
    print("mealData");
    print(mealData);
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(mealData)['recipes']);

    mealsList = dataDecoded.map((e) => Meal.fromJson(e)).toList();
    notifyListeners();
  }
}
