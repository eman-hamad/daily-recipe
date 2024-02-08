
import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
        decoration: BoxDecoration(
 color: llightGrey,),
//  border:const BoxBorder(


//  )
//        // shape: Border(borderRadius: BorderRadius.circular(25))
//         ),
       

        // width: MediaQuery.of(context).size.width,
        // margin: const EdgeInsets.symmetric(horizontal: 5.0),
        // decoration: BoxDecoration(
        //     color: llightGrey,
        //     borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(16),
        
               
                child: Row(children: [
                   ImageIcon(
                    AssetImage(
                      ImagePath.languageIcon,
                    ),
                  ),
                  const Text("Language"),
                 
                  Spacer(),
                  Text(
                    "English",
                    style: TextStyle(color: orange),
                  )
                ]),
        )
              )
            ])));
  }
}
