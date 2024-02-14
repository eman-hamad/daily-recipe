import 'dart:async';

import 'package:daily_recipe/constants/colors.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/view_model/provider/app_auth_provider.dart';
import 'package:daily_recipe/views/drawer_views/profile_screen_view/profile_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

class DrawerHeaderWidget extends StatefulWidget {
  final String? name;
  DrawerHeaderWidget({super.key, this.name});

  @override
  State<DrawerHeaderWidget> createState() => _DrawerHeaderWidgetState();
}

class _DrawerHeaderWidgetState extends State<DrawerHeaderWidget> {
  String src =
      "https://starvationaccountability.org/wp-content/uploads/2022/02/Person-Image.jpg";

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: (){
       
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
           
        },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
        ),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
             CircleAvatar(child: Image.network(
                
                 Provider.of<AppAuthProvider>(context).img!= null
              
                        ?
                    Provider.of<AppAuthProvider>(context).img!
                    :                          
                                    
                src, fit: BoxFit.cover))
                ,
            
            SizedBox(width: 10,),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name!,
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "View Profile",
                  style: TextStyle(color: ligthGrey, fontSize: 12),
                ),
              ],
            ),
            //  SizedBox(
            //   width: 10,
            //  ),
            //  Spacer(),
            //     ImageIcon(
            //       AssetImage(
            //         ImagePath.notificationIcon,
            //       ),
            //     ),
        
            //Text("data"),
            // Text("data"),
            // Text("data"),
          ],
        ),
      ),
    );
  }
}
