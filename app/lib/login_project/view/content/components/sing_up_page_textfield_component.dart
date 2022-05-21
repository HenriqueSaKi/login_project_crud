import 'package:flutter/material.dart';

class SignUpTextField extends StatefulWidget {
  EdgeInsets padding;
  Size size;
  TextEditingController controller;
  String text;
  Icon icon;

  SignUpTextField(
      {required this.padding,
      required this.size,
      required this.controller,
      required this.text,
      required this.icon,
      Key? key})
      : super(key: key);

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.size.height / 12,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.text,
          prefixIcon: widget.icon,
        ),
      ),
    );
  }
}
