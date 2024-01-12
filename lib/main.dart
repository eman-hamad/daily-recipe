import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/cubit/meal_cubit.dart';
import 'package:daily_recipe/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
var pereference = await SharedPreferences.getInstance();
GetIt.I.registerSingleton<SharedPreferences>(pereference) ;
  runApp(BlocProvider<MealCubit>(create: ( context) => MealCubit(), child:  const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Daily Recipe',
        theme: ThemeData(
          fontFamily: "Hellix",

          // textTheme: Theme.of(context).textTheme.apply(

          //      // fontFamily: 'Hellix',
          //       //fontSizeFactor: 3
          //     ),
          colorScheme: ColorScheme.fromSeed(seedColor: orange),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
