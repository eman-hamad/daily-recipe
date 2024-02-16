import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/views/login_screen.dart';
import 'package:daily_recipe/views/signup_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../../views/components/snackbar_widget.dart';
import '../../views/home_screen_view/home_screen.dart';

class AppAuthProvider extends ChangeNotifier {


  TextEditingController? emailController;
  TextEditingController? nameController;
  TextEditingController? passwordController;
  // TextEditingController? editNameController;
  
  GlobalKey<FormState>? formKey;
  // GlobalKey<FormState>? forgetEmailFormKey;
  // GlobalKey<FormState>? updateProfileFormKey;
  
  bool? isHidden;

  bool isPressed = false;
  String? img;
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
    //formKey = GlobalKey<FormState>();
    isHidden = false;
  }

  // void initAuthProviderEdit() {
  //   editNameController = TextEditingController();
  //   updateProfileFormKey = GlobalKey<FormState>();
  // }

  // void initAuthProviderForget() {
  //   forgetEmailController = TextEditingController();
  //   forgetEmailFormKey = GlobalKey<FormState>();
  // }

  // void disposeAuthProviderForget() {
  //   forgetEmailController = null;
  //   forgetEmailFormKey = null;
  // }

  // void disposeAuthProviderEdit() {
  //   editNameController = null;
  //   updateProfileFormKey = null;
  // }

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

  Future<void> signUp(BuildContext context, String name) async {
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
        // print("nameController!.text");
        // print(nameController!.text);
        if (user != null) {
          SnackBarWidget(
                  context: context,
                  txt: "signed up Successfuly",
                  color: lightBlue)
              .makeSnackBar();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(name: name)),
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
                  color: Colors.red)
              .makeSnackBar();
          break;
        case "ERROR_WEAK_PASSWORD":
          SnackBarWidget(
                  context: context,
                  txt: "Your password is too weak",
                  color: Colors.red)
              .makeSnackBar();
          break;
        case "ERROR_INVALID_EMAIL":
          SnackBarWidget(
                  context: context,
                  txt: "Your email is invalid",
                  color: Colors.red)
              .makeSnackBar();
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          SnackBarWidget(
                  context: context,
                  txt: "Email is already in use on different account",
                  color: Colors.red)
              .makeSnackBar();
          break;
        case "ERROR_INVALID_CREDENTIAL":
          SnackBarWidget(
                  context: context,
                  txt: "Your email is invalid",
                  color: Colors.red)
              .makeSnackBar();
          break;

        default:
          SnackBarWidget(
                  context: context,
                  txt: e.message.toString(),
                  color: Colors.red)
              .makeSnackBar();
      }
    }
  }

  Future<void> login(BuildContext context) async {
    try {
      if (!formKey!.currentState!.validate()) {
        SnackBarWidget(
                context: context,
                txt: 'Please Fill Empty Fields !',
                color: Colors.red)
            .makeSnackBar();
           
      } else {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );
        if (user != null) {
          SnackBarWidget(
                  context: context,
                  txt: "logged in Successfuly",
                  color: lightBlue)
              .makeSnackBar();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);
          disposeAuthProvider();
        }
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          SnackBarWidget(
                  context: context,
                  txt: "the email address is not valid",
                  color: Colors.red)
              .makeSnackBar();
          break;

        case "user-disabled":
          SnackBarWidget(
                  context: context,
                  txt: "the given email has been disabled",
                  color: Colors.red)
              .makeSnackBar();
          break;

        case "user-not-found":
          SnackBarWidget(
                  context: context,
                  txt: "no user corresponding to the given email",
                  color: Colors.red)
              .makeSnackBar();
          break;

        case "wrong-password" || "INVALID_LOGIN_CREDENTIALS":
          SnackBarWidget(
                  context: context,
                  txt: "password or email is invalid",
                  color: Colors.red)
              .makeSnackBar();
          break;
        case "too_many_requets":
          SnackBarWidget(
                  context: context,
                  txt: "Too many requests. Try again later",
                  color: Colors.red)
              .makeSnackBar();
          break;

        default:
          SnackBarWidget(
                  context: context,
                  txt: "Invalid , Try Again Later",
                  color: Colors.red)
              .makeSnackBar();
      }
    }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      if (!formKey!.currentState!.validate()) {
        SnackBarWidget(
                context: context,
                txt: 'Please Fill Empty Fields !',
                color: Colors.red)
            .makeSnackBar();
            
      } else {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

     
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
        disposeAuthProvider();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          SnackBarWidget(
                  context: context,
                  txt: "the email address is not valid",
                  color: Colors.red)
              .makeSnackBar();
          break;

        case "user-disabled":
          SnackBarWidget(
                  context: context,
                  txt: "the given email has been disabled",
                  color: Colors.red)
              .makeSnackBar();
          break;

        case "user-not-found":
          SnackBarWidget(
                  context: context,
                  txt: "no user corresponding to the given email",
                  color: Colors.red)
              .makeSnackBar();
          break;

       
        case "too_many_requets":
          SnackBarWidget(
                  context: context,
                  txt: "Too many requests. Try again later",
                  color: Colors.red)
              .makeSnackBar();
          break;

        default:
          SnackBarWidget(
                  context: context,
                  txt: "Invalid , Try Again Later",
                  color: Colors.red)
              .makeSnackBar();
      }
    }
  }


  void rebuild() {
    isPressed = true;
    notifyListeners();
  }

  num servingValue = 4;
  num timeValue = 75;
  num caloriesValue = 300;
  void rebuildServing(num value) {
    servingValue = value;
    notifyListeners();
  }

  void rebuildTime(num value) {
    timeValue = value;
    notifyListeners();
  }

  void rebuildCalories(num value) {
    caloriesValue = value;
    notifyListeners();
  }

  void signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(const Duration(seconds: 1));
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }
    OverlayLoadingProgress.stop();
  }

  Future<void> updateImgProfile() async {
    OverlayLoadingProgress.start();

    var imageResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    var refresnce = FirebaseStorage.instance
        .ref('profile_pictures/${imageResult?.files.first.name}');

    if (imageResult?.files.first.bytes != null) {
      var uploadResult = await refresnce.putData(
          imageResult!.files.first.bytes!,
          SettableMetadata(contentType: 'image/png'));

      if (uploadResult.state == TaskState.success) {
        img = "${await refresnce.getDownloadURL()}";
        notifyListeners();

        OverlayLoadingProgress.stop();
        // print(
        //     '?????image upload successfully ${await refresnce.getDownloadURL()}');
      }
    }
  }

  void updateUserName(BuildContext context) {
    if (formKey?.currentState?.validate() ?? false) {
      FirebaseAuth.instance.currentUser!
          .updateDisplayName(nameController!.text);

      SnackBarWidget(
        context: context,
        txt: "Successfully Updated",
        color: deepGreen,
      ).makeSnackBar();
      Navigator.pop(context);
    }
    notifyListeners();
  }
}
