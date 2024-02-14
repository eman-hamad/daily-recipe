import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/views/drawer_views/profile_screen_view/profile_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
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
        body: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 12),
                  child: Text("Settings" , style: TextStyle(
                    fontSize: 21,
                   fontWeight: FontWeight.w400
                  ),),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: llightGrey,
                     borderRadius: BorderRadius.circular(15)
                           // shape: Border(borderRadius: BorderRadius.circular(25))
                            
                    ),
                   
                
                    // width: MediaQuery.of(context).size.width,
                    // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    // decoration: BoxDecoration(
                    //     color: llightGrey,
                    //     borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                      child: Row(children: [
                        ImageIcon(
                          AssetImage(
                            ImagePath.languageIcon,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          "Language",
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Text("English",
                            style: TextStyle(
                              color: orange,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w400,
                            ))
                      ]),
                    )),


                 SizedBox(
                  height: 10,
                 ),

               InkWell(
                onTap: (){
                         Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()));
                      },
                 child: Container(
                      decoration: BoxDecoration(
                        color: llightGrey,
                       borderRadius: BorderRadius.circular(15)
                             // shape: Border(borderRadius: BorderRadius.circular(25))
                              
                      ),
                     
                  
                      // width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      // decoration: BoxDecoration(
                      //     color: llightGrey,
                      //     borderRadius: BorderRadius.circular(25)),
                      child:  Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          
                          children: [
                         Icon(Icons.person, size: 30, color: ligthGrey,),
                         
                           SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Edit Profile",
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          
                        ]),
                      )
                      ),
               ),
              ]
            )));
  }
}
