import 'package:flutter/material.dart';


// widget
class TextButtonWidget extends StatelessWidget {
  final String txt;
  final Function() press;
  final Color? color;
 // double? font = 17.0;
  // double? pad = 18.0;
  TextButtonWidget(
      {super.key, required this.press, required this.txt,
       //this.font,
        this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextButton(
          style: TextButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              // padding: EdgeInsets.symmetric(
              //   vertical: pad!,
              // ),
              foregroundColor: Colors.white,
              backgroundColor: color,),
              onPressed: press,
              child: Text(
                txt,
                style: TextStyle(
                  fontWeight: FontWeight.w600, 
                  fontSize: 17),
              )),
        );
  }
}
