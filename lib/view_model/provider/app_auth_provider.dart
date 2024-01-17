import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/views/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../views/components/snackbar_widget.dart';
import '../../views/home_screen.dart';

class AppAuthProvider extends ChangeNotifier {
  TextEditingController? emailController;
  TextEditingController? nameController;
  TextEditingController? passwordController;
  GlobalKey<FormState>? formKey;
  bool? isHidden;

  void initAuthProviderSignUp() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    formKey = GlobalKey<FormState>();
    isHidden = false;
  }
 void initAuthProviderLogin() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    isHidden = false;
  }
  void disposeAuthProvider() {
    emailController = null;
    passwordController = null;
    nameController = null;
    formKey = null;
    isHidden = false;
  }

  void openRegisterScreen(BuildContext context) {
    disposeAuthProvider();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (!formKey!.currentState!.validate()) {
        SnackBarWidget(
            context: context,
            txt: 'Please Fill Empty Fields !',
            color: Colors.red);
      } else {
        final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        if (user != null) {
          SnackBarWidget(
              context: context, txt: "signed up Successfuly", color: lightBlue).makeSnackBar();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false);
          disposeAuthProvider();
        }
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          SnackBarWidget(
              context: context,
              txt: "Anonymous accounts are not enabled",
              color: Colors.red).makeSnackBar();
          break;
        case "ERROR_WEAK_PASSWORD":
          SnackBarWidget(
              context: context,
              txt: "Your password is too weak",
              color: Colors.red).makeSnackBar();
          break;
        case "ERROR_INVALID_EMAIL":
          SnackBarWidget(
              context: context,
              txt: "Your email is invalid",
              color: Colors.red).makeSnackBar();
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          SnackBarWidget(
              context: context,
              txt: "Email is already in use on different account",
              color: Colors.red).makeSnackBar();
          break;
        case "ERROR_INVALID_CREDENTIAL":
          SnackBarWidget(
              context: context,
              txt: "Your email is invalid",
              color: Colors.red).makeSnackBar();
          break;

        default:
          SnackBarWidget(
              context: context, txt: e.message.toString(), color: Colors.red).makeSnackBar();
      }
    }
  }


  
  Future<void> login(BuildContext context) async {
    try {

        if (!formKey!.currentState!.validate()) {
        SnackBarWidget(
            context: context,
            txt: 'Please Fill Empty Fields !',
            color: Colors.red).makeSnackBar().makeSnackBar();
      } else {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController!.text,
        password: passwordController!.text!,
      );
      if (user != null) {
        SnackBarWidget(context: context, txt: "logged in Successfuly", color:lightBlue).makeSnackBar();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
             disposeAuthProvider();
      }}
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          SnackBarWidget(context: context, txt:"the email address is not valid",color: Colors.red).makeSnackBar();
          break;

        case "user-disabled":
          SnackBarWidget(
            context: context, txt: "the given email has been disabled",color: Colors.red).makeSnackBar();
          break;

        case "user-not-found":
          SnackBarWidget(
            context: context, txt: "no user corresponding to the given email",color: Colors.red).makeSnackBar();
          break;

        case "wrong-password" || "INVALID_LOGIN_CREDENTIALS":
          SnackBarWidget(context: context, txt: "password or email is invalid", color:Colors.red).makeSnackBar();
          break;
        case "too_many_requets":
          SnackBarWidget(
              context: context, txt: "Too many requests. Try again later",color: Colors.red).makeSnackBar();
          break;

        default:
          SnackBarWidget(context: context, txt:"Invalid , Try Again Later", color:Colors.red).makeSnackBar();
      }
    }
  }


}
