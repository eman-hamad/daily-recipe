import 'package:daily_recipe/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/images.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  void checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    if (GetIt.I.get<SharedPreferences>().getBool('isLogin') ?? false) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => WelcomeScreen()));
    }

    //PreferencesService.prefs = await SharedPreferences.getInstance();
    //var email = PreferencesService.prefs!.getString("email");
    //print(prefrenceInstance.getString("email"));
    // FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.splashImg), fit: BoxFit.cover)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(
              color: orange,
            ),
          ),
        ));
  }
}
