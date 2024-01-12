
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/meal.model.dart';

@immutable
abstract class MealStates  {}



class InitialState extends MealStates {
  final List<Meal> mealsList;
  InitialState(this.mealsList);

}
