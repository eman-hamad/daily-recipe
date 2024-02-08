// import 'dart:convert';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../models/meal.model.dart';
// import '../../models/meal_model2.dart';

// class MealProvider extends ChangeNotifier {
//  // List<Meal> mealsList = [];

//   // Future<void> getMeals() async {
//   //   var mealData = await rootBundle.loadString('assets/data/sample.json');
//   //   // print("mealData");
//   //   // print(mealData);
//   //   var dataDecoded =
//   //       List<Map<String, dynamic>>.from(jsonDecode(mealData)['recipes']);

//   //   mealsList = dataDecoded.map((e) => Meal.fromJson(e)).toList();
//   //   notifyListeners();
//   // }

//   List<MyMeal>? _adsList;

//   List<MyMeal>? get adsList => _adsList;
//   Future<void> getFirebaseAds() async {
//     try {
//       var result = await FirebaseFirestore.instance.collection('recipes').get();
//       print("_adsListttttttttttttt");
//       print(result.docs);
//       if (result.docs.isNotEmpty) {
//         _adsList =
//             result.docs.map((doc) => MyMeal.fromJson(doc.data(), doc.id)).toList();
//         print("_adsList");
//         print(_adsList);
//       } else {
//         _adsList = [];
//       }
//       notifyListeners();
//     } catch (e) {
//       _adsList = [];
//       notifyListeners();
//     }
//   }

//   CarouselController? carouselController;

//   void disposeCarousel() {
//     carouselController = null;
//   }
// }
