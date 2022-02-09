import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefixIcon;
  final String hintText;
  final String labelText;
  final Color fillColor;

  const CustomFormField(
      {required this.controller,
      required this.prefixIcon,
      required this.hintText,
      required this.labelText, required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          labelText: labelText,
          fillColor: fillColor,
        ),
      ),
    );
  }
}
