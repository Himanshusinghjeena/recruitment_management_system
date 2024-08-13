import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  const CustomButton(
      { required this.innerText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style:  TextStyle(color: Theme.of(context).canvasColor, fontSize: 20),
        ),
      ),
    );
  }
}
