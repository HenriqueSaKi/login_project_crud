import 'package:flutter/material.dart';

class AccountSettingsTextField extends StatefulWidget {
  EdgeInsets padding;
  Size size;
  TextEditingController controller;
  bool readOnly;
  String text;
  Icon icon;

  AccountSettingsTextField(
      {required this.padding,
      required this.size,
      required this.controller,
      required this.readOnly,
      required this.text,
      required this.icon,
      Key? key})
      : super(key: key);

  @override
  State<AccountSettingsTextField> createState() =>
      _AccountSettingsTextFieldState();
}

class _AccountSettingsTextFieldState extends State<AccountSettingsTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      height: widget.size.height / 12,
      child: TextField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.text,
          prefixIcon: widget.icon,
        ),
      ),
    );
  }
}
