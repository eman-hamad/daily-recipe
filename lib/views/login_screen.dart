import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../services/preferences.services.dart';
import 'components/snackbar_widget.dart';
import 'components/text_button.dart';
import 'components/text_form_field.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  late GlobalKey<FormState> formKey;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagePath.signinImg), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
             // mainAxisAlignment: M,
              children: [
                Expanded(
                  // flex: 3,
                  child: Center(
                    child: Form(
                      key: formKey,
                        child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                                hint: "Email address ",
                                txt: emailController,
                                widget: Icon(
                                  Icons.email_outlined,
                                  color: ligthGrey,
                                ),
                                type: TextInputType.emailAddress,
                                obscure: false,
                                formatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z || @ || . || 0-9]')),
                                ]
                                //  true
                                ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                                hint: "Password ",
                                txt: passwordController,
                                widget: Icon(
                                  Icons.lock,
                                  color: ligthGrey,
                                ),
                                type: TextInputType.text,
                                obscure: true,
                                formatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-zA-Z || 0-9]')),
                                ]
                                //false
                                ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButtonWidget(
                              font: 19.0,
                              press: () async {
                                if (!formKey.currentState!.validate()) {
                                  
                                  SnackBarWidget(
                                          context: context,
                                          txt: 'Please Fill Empty Fields !',
                                          color: Colors.red)
                                      .makeSnackBar();
                                } else {
                                  formKey.currentState!.save();
                  
                                  await
                                  PreferencesService.prefs?.setBool('isLogin', true);
                                  // PreferencesService.prefs!
                                  //     .setString("email", "$emailController");
                                  // PreferencesService.prefs!
                                  //     .setString("password", "$passwordController");
                                      print(PreferencesService.prefs);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HomeScreen()));
                                }
                              },
                              txt: "Sign In",
                              color: orange,
                            ),
                  
                            // Spacer(),
                        
                          ],
                        ),
                      ),
                    )),
                  ),
                ),
            
            // Expanded(
            
            //   child: SizedBox(
            //     //height: ,
            //   ),
            // ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    //          crossAxisAlignment: CrossAxisAlignment.end,
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an acount?', style: TextStyle(color: ligthGrey),),
                     SizedBox(
                      width: 5,
                     ),
                      RichText(
                        text: TextSpan(
                          text: 'Register.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: orange),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()));
                            },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            
          ),
        ));
  }
}
