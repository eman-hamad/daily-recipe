import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  final BuildContext context;
  final String txt;
  final Color color;

  const SnackBarWidget(
      {super.key,
      required this.color,
      required this.context,
      required this.txt});

  makeSnackBar() {
    var snackBar = SnackBar(
      content: Text(
        txt,
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: color,
    );
    return ScaffoldMessenger.of(context).showSnackBar(
      snackBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
