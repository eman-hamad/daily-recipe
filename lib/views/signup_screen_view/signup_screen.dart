import 'package:daily_recipe/utils/global_keys.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/views/login_screen_view/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../view_model/provider/app_auth_provider.dart';
import '../components/text_button.dart';
import '../components/text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false)
        .initAuthProviderSignUp();
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
                  image: AssetImage(ImagePath.registerImg), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  // flex: 3,
                  child: Center(
                    child: Form(
                        key: GKeys.signupFormKey,
                        child: SingleChildScrollView(
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFieldWidget(
                                    hint: "Full Name",
                                    txt: Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .nameController!,
                                    widget: Icon(
                                      Icons.person_2_outlined,
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
                                    hint: "Email address ",
                                    txt: Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .emailController!,
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
                                    txt: Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .passwordController!,
                                    widget: Icon(
                                      Icons.lock,
                                      color: ligthGrey,
                                    ),
                                    suffixWidget: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Provider.of<AppAuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .isHidden =
                                                !Provider.of<AppAuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .isHidden!;
                                          });
                                          // print(isHidden);
                                        },
                                        child: Icon(
                                          Provider.of<AppAuthProvider>(context,
                                                      listen: false)
                                                  .isHidden!
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: ligthGrey,
                                        )),
                                    type: TextInputType.text,
                                    obscure: Provider.of<AppAuthProvider>(
                                            context,
                                            listen: false)
                                        .isHidden!,
                                    formatter: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z || 0-9]')),
                                    ]
                                    //false
                                    ),
                                const SizedBox(
                                  height: 60,
                                ),
                                TextButtonWidget(
                                  press: () async {
                                    var name = Provider.of<AppAuthProvider>(
                                            context,
                                            listen: false)
                                        .nameController!
                                        .text;
                                    Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .signUp(context, name);
                                  },
                                  txt: "Register",
                                  color: orange,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already registered?',
                          style: TextStyle(
                              color: ligthGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Sign in.',
                            style: TextStyle(
                                //fontFamily: 'Hellix',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: orange),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
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
