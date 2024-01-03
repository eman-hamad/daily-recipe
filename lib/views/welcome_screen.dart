import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/views/login_screen.dart';
import 'package:flutter/material.dart';
import '../utils/images.dart';
import 'components/text_button.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.splashImg), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButtonWidget(
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  txt: "Register",
                  color: orange,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: TextButtonWidget(
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    txt: "Sign In",
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
