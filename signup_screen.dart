import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../services/preferences.services.dart';
import 'components/snackbar_widget.dart';
import 'components/text_button.dart';
import 'components/text_form_field.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  late TextEditingController userController;

  late TextEditingController passwordController ;

  late TextEditingController emailController ;

  late TextEditingController phoneController;

  late TextEditingController locationController ;

  late GlobalKey<FormState> formKey ;


@override
  void initState() {
    
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userController = TextEditingController();
    passwordController = TextEditingController();
    locationController =TextEditingController();
    formKey = GlobalKey<FormState>();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "././assets/images/splash2.png",
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
       Scaffold(
          backgroundColor: Colors.transparent,
     
        // resizeToAvoidBottomInset: true,
       
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Sign up",
            style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),
          ),
          backgroundColor:  Colors.deepPurple[300],
        ),
        body: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 30,
                            color: lightBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        hint: "User Name",
                        txt: userController,
                        widget: Icon(
                          Icons.person,
                          color: lightBlack,
                        ),
                        type: TextInputType.name,
                        obscure: false,
                        formatter: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ]
                        //false
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        hint: "Email addresse or phone number",
                        txt: emailController,
                        widget: Icon(
                          Icons.email,
                          color: lightBlack,
                        ),
                        type: TextInputType.emailAddress,
                        obscure: false,
                        formatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z || @ || . || 0-9]')),
                        ]
                        //  ,true
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        hint: "Phone",
                        txt: phoneController,
                        widget: Icon(
                          Icons.phone,
                          color: lightBlack,
                        ),
                        type: TextInputType.phone,
                        obscure: false,
                        formatter: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ]
                        //false
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        hint: "Password",
                        txt: passwordController,
                        widget: Icon(
                          Icons.password,
                          color: lightBlack,
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
                      height: 10,
                    ),
                    TextFieldWidget(
                        hint: "Location ",
                        txt: locationController,
                        widget: Icon(
                          Icons.maps_home_work,
                          color: lightBlack,
                        ),
                        type: TextInputType.name,
                        obscure: false,
                        formatter: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ]
                        //false
                        ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextButtonWidget(
                        
                            font: 19.0,
                            press: () async{
                              //viewmodel.register(userController.text , passwordController.text);
    
                              if (!formKey.currentState!.validate()) {
                                SnackBarWidget(
                                        context: context,
                                        txt: 'Please Fill Empty Fields !',
                                        color: Colors.red)
                                    .makeSnackBar();
                              } else {
                                formKey.currentState!.save();
                              
                                    await PreferencesService.prefs?.setBool('isLogin', true);
                               PreferencesService.prefs!
                                    .setString("email", "$emailController");
                                PreferencesService.prefs!
                                    .setString("password", "$passwordController");
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomeScreen()),
                                    (Route<dynamic> route) => false);
                              }
                            },
                            txt: "Signup"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),]
    );
  }
}
