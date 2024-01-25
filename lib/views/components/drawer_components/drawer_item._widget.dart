import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../../../view_model/provider/app_auth_provider.dart';

class DrawerItemWidget extends StatelessWidget {
  String img;
  String txt;
  Function () press;
  DrawerItemWidget(
      {super.key, required this.img, required this.press, required this.txt});

  @override
  Widget build(BuildContext context) {
    return
    //  ZoomDrawer(
    //   slideWidth: MediaQuery.of(context).size.width * 0.65,
    //   menuBackgroundColor: Colors.white,
    //   boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
    //   disableDragGesture: true,
    //   mainScreenTapClose: true,
    //   controller: controller,
    //   drawerShadowsBackgroundColor: Colors.grey,
    //   menuScreen: Scaffold(
    //     backgroundColor: Colors.white,
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           ListTile(
    //             onTap: () {
    //               controller.close?.call();
    //               Navigator.push(context,
    //                   MaterialPageRoute(builder: (_) => IngredientPage()));
    //             },
    //             leading: Icon(Icons.food_bank),
    //             title: Text('Ingredients'),
    //           ),
    //           ListTile(
    //             onTap: () {
    //               Provider.of<AppAuthProvider>(context, listen: false)
    //                   .signOut(context);
    //             },
    //             leading: Icon(Icons.logout),
    //             title: Text('Logout'),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    //   mainScreen: Scaffold(
    //     appBar: AppBar(
    //       leading: Padding(
    //         padding:
    //             EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
    //         child: InkWell(
    //             onTap: () {
    //               controller.toggle!();
    //             },
    //             child: Icon(Icons.menu)),
    //       ),
    //       actions: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(
    //               horizontal: Numbers.appHorizontalPadding),
    //           child: Icon(Icons.notifications),
    //         )
    //       ],
    //    )) ); 
    
    
    ListTile(
    
      selectedColor: Colors.orange ,
        leading: ImageIcon(

          AssetImage(img),
          //color: Colors.orange,
          
        ),
        title: Text(txt),
        onTap: press);
  }
}
