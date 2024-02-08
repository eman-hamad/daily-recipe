import 'package:daily_recipe/constants/colors.dart';
import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  // String img;
  String txt;
  Widget iconWidget;
  Function() press;
  DrawerItemWidget(
      {super.key,
      // required this.img,
      required this.press,
      required this.txt,
      required this.iconWidget});

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
        
            //selectedColor: Colors.orange ,
            leading: iconWidget,
            //  ImageIcon(
        
            //   AssetImage(img),
            //   //color: Colors.orange,
        
            // ),
            title: Text(
              txt,
              style: TextStyle(
                  color:ligthGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            onTap: press);
  }
}
