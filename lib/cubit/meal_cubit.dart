

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/meal.model.dart';
import 'app_states.dart';



class MealCubit extends Cubit<MealStates> {
  MealCubit() : super(UserLoadedState(const []));

  // void increment() => emit(UserState(state.counterValue + 1));
  // void decrement() => emit(UserState(state.counterValue - 1));

  
  List<Meal> mealsList = [];

   getMeals() async {
   
    var mealData = await rootBundle.loadString('assets/data/sample.json');
    print("mealData");
    print(mealData);
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(mealData)['recipes']);

    mealsList = dataDecoded.map((e) => Meal.fromJson(e)).toList();
     UserLoadedState(mealsList);
  }

}