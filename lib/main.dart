import 'dart:io';

import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:daily_recipe/view_model/provider/meal_provider.dart';
import 'package:daily_recipe/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_model/provider/ingredient.provider.dart';
import 'view_model/provider/recipes.provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
 Platform.isAndroid ?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:  "AIzaSyAVWso_xB0KNkG6a7q_u9tWE1PsfbrQTbs",
      appId: "1:497409280819:android:8e9eb2f1eb28705cea8c46",
      messagingSenderId: "497409280819",
      projectId: "dailyrecipes-21e6f",
      storageBucket: "dailyrecipes-21e6f.appspot.com"
    ),
  ):

  await Firebase.initializeApp();
  //var pereference = await SharedPreferences.getInstance();
  //GetIt.I.registerSingleton<SharedPreferences>(pereference);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => RecipesProvider()),
   ChangeNotifierProvider(create: (_) => AppAuthProvider()),

       ChangeNotifierProvider(create: (_) => IngredientsProvider()),
    ], child: const MyApp()),
  );
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
