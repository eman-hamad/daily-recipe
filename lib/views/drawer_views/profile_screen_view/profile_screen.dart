import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/global_keys.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:daily_recipe/views/components/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false)
        .initAuthProviderSignUp();

    super.initState();
  }

  // String? photo = FirebaseAuth.instance.currentUser!.photoURL;

  String? src =
      "https://starvationaccountability.org/wp-content/uploads/2022/02/Person-Image.jpg";
  @override
  Widget build(BuildContext context) {
    // print("====================photo=${Provider.of<AuthProviderViewModel>(context, listen: false).photo}=============================");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              // _key.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageIcon(
                AssetImage(
                  ImagePath.menuIcon,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageIcon(
                AssetImage(
                  ImagePath.notificationIcon,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
            ),
            Form(
              key: GKeys.updateProfileFormKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<AppAuthProvider>(
                        builder: (context, authProvider, child) {
                      return Center(
                        child: Stack(
                          children: [
                            authProvider.img != null

                                // _profileImage != null
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        authProvider.img!,
                                        scale: 30))
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        NetworkImage(src!, scale: 30)),

                            /*CircleAvatar(
                                    radius: 40,
                                    backgroundImage:NetworkImage(image)
                                    //NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                                              
                                  ),*/
                            Positioned(
                                // bottom: 5,
                                // right:5 ,
                                bottom: 1,
                                right: 1,
                                child: InkWell(
                                  onTap: () async {
                                    await Provider.of<AppAuthProvider>(context,
                                            listen: false)
                                        .updateImgProfile();

                                    //               src= Provider.of<AppAuthProvider>(context
                                    //  ,listen: false ).img;
                                  },

                                  /*Provider.of<AuthProviderViewModel>(context,
                                                  listen: false)*/

                                  // print(
                                  //     " ================photo before update =${value.photo} ========================");
                                  // await  Provider.of<AuthProviderViewModel>(context
                                  //    ,listen: false ).updateImageProfile();
                                  // value.downloadURL=FirebaseAuth.instance.currentUser!.photoURL;

                                  //photo = FirebaseAuth.instance.currentUser!.photoURL;
                                  // print(
                                  //     " ================photo after update =${value.photo} ========================");

                                  child: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: orange,
                                  ),
                                ))
                          ],
                        ),
                      );
                    }),
                    // TextFormField(

                    //   // onChanged: (valid) => value
                    //   //     .updateProfileFormKey?.currentState
                    //   //     ?.validate(),
                    //   style: const TextStyle(
                    //       color: Colors.deepOrange, fontSize: 18),
                    //   //controller: value.usernameController,
                    //   decoration:  InputDecoration(
                    //     prefixIcon: Icon(Icons.person , size: 30, color: orange,),
                    //     labelText: 'User name',
                    //     labelStyle: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   validator: (valid) {
                    //     if (valid == null || valid.isEmpty) {
                    //       print("Please enter your name.");
                    //       return 'Please enter your name.';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    TextFieldWidget(
                      formatter: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z || @ || . || 0-9]')),
                      ],
                      hint: "Type user Name To Edit",
                      obscure: false,
                      txt: Provider.of<AppAuthProvider>(context, listen: false)
                          .nameController!,
                      widget: Icon(
                        Icons.person,
                        size: 30,
                        color: orange,
                      ),
                      type: TextInputType.text,
                    ),
                    /*Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              onChanged: (valid) => value.formKey?.currentState?.validate(),
                              style:
                                  const TextStyle(color: Colors.deepOrange, fontSize: 18),
                              controller: value.usernameController,
                  
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: 'User name',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              validator: (valid) {
                                if (valid!.isEmpty ||
                                    !RegExp(r'^[a-zA-Z ]+$').hasMatch(valid)) {
                                if (valid == null || valid.isEmpty) {
                                  print("Please enter your name.");
                                  return 'Please enter your name.';
                                }
                                return null;
                              }
                              }
                            ),
                          ),*/
                    /*  Padding(
                            padding: const EdgeInsets.only(bottom: 10.0,right: 10,left: 10),
                            child: TextFormField(
                              onChanged: (valid) => value.updateProfileFormKey?.currentState?.validate(),
                              style:
                              const TextStyle(color: Colors.deepOrange, fontSize: 18),
                              controller: value
                                  .phoneController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone_android),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              validator: (valid) {
                                if (valid!.isEmpty ||
                                    !RegExp(r'^(02|010|011|012|015)\d{8}$')
                                        .hasMatch(valid)) {
                                  print("Please enter your Phone Number.");
                                  return 'Please enter your Phone Number.';
                                }
                                return null;
                              },
                            ),
                          ),*/
                    SizedBox(height: 60),
                    // Spacer(),

                    TextButtonWidget(
                      press: () async {
                        Provider.of<AppAuthProvider>(context, listen: false)
                            .updateUserName(context);

                        ///Navigator.pop(context);
                        // if (!Provider.of<AppAuthProvider>(context, listen: false).formKey!.currentState!.validate()) {
                        //   SnackBarWidget(
                        //           context: context,
                        //           txt: 'Please Fill Empty Fields !',
                        //           color: Colors.red)
                        //       .makeSnackBar();
                        // } else {
                        //   Provider.of<AppAuthProvider>(context, listen: false).formKey!.currentState!.save();

                        //   // GetIt.I
                        //   //     .get<SharedPreferences>()
                        //   //     .setBool('isLogin', true);
                        //   // PreferencesService.prefs!
                        //   //     .setString("email", "$emailController");
                        //   // PreferencesService.prefs!
                        //   //     .setString("password", "$passwordController");
                        //   // Navigator.pushReplacement(
                        //   //     context,
                        //   //     MaterialPageRoute(
                        //   //         builder: (context) =>
                        //   //             const HomeScreen()));
                        //}
                      },
                      txt: "Edit",
                      color: orange,
                    ),
                  ]),
            ),
          ]),
        )));
  }
}
