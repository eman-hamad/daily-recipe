import 'package:daily_recipe/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/images.dart';
import '../home_screen_view/home_screen.dart';
import '../welcome_screen_view/welcome_screen.dart';

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

    // if (GetIt.I.get<SharedPreferences>().getBool('isLogin') ?? false) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const WelcomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
    });
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
