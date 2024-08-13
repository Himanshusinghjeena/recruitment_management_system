import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  TextEditingController? controller;
  Icon? icon;
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  bool obscureText;

  CustomInputField(
      {Key? key,
      this.controller,
      this.icon,
      required this.labelText,
      required this.hintText,
      required this.validator,
      this.suffixIcon = false,
      this.obscureText = false});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          border:  OutlineInputBorder(
              borderSide:
              const  BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)
          ),
          enabledBorder:  OutlineInputBorder(
              borderSide:
                    const  BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder:  OutlineInputBorder(
              borderSide:
                    const  BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
          ),
          hintText: widget.hintText,
          prefixIcon: widget.icon,
          labelText: widget.labelText,
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                )
              : null,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
      ),
    );
  }
}
