import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/provider/meal_provider.dart';
import 'package:daily_recipe/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pereference = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(pereference);
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => MealProvider())],
        child: const MyApp()),
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
