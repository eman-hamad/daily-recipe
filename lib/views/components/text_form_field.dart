import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';

class TextFieldWidget extends StatelessWidget {

  final String hint;
  final TextEditingController txt;
  final Widget widget;
  final TextInputType type;
  final bool obscure;
  final List<TextInputFormatter> formatter;

  const TextFieldWidget(
      {super.key,
      required this.formatter,
      required this.hint,
      required this.obscure,
      required this.txt,
      required this.type,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      
        controller: txt,
        style: TextStyle(color: ligthGrey),
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor:  ligthGrey,
        keyboardType: type,
        inputFormatters: formatter,
        validator: (value) {
          //   if (isEmail == true  && (value!.isEmpty|| !value.contains("@") || !value.contains(".")))
          //   {

          //                   return "Please Fill correctly";

          // }

          if (value!.isEmpty) {
            return "Please Fill correctly";
          } else if (value.length < 2) {
            return "must be greater than two characters";
          }
          return null;
        },
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: widget,

          fillColor: ligthGrey,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide( width: 1, color:  ligthGrey),
          ),
          hintText: hint,

          hintStyle: TextStyle(color:  ligthGrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color:  ligthGrey),
          ),
        ));

  }
}


    