
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/meal.model.dart';

@immutable
abstract class MealStates extends Equatable {}

//data loading state
class UserLoadingState extends MealStates {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends MealStates {
  final List<Meal> mealsList;
  UserLoadedState(this.mealsList);
  @override
  List<Object?> get props => [mealsList];
}
class UserErrorState extends MealStates {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}