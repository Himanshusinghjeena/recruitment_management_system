import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
      BuildContext context, String message,
      {Color backgroundColor = Colors.black,
        SnackBarBehavior behavior = SnackBarBehavior.floating,
        EdgeInsetsGeometry? margin,
        double elevation = 10.0}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: behavior,
        margin: margin ?? EdgeInsets.all(5),
        elevation: elevation,
      ),
    );
  }
}
