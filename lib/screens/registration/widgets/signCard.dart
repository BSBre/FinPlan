

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignCard extends StatelessWidget {

  final double size;
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final bool hidden;

  SignCard({required this.size, required this.icon, required this.title, required this.controller, required this.hidden});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: TextFormField(
          controller: controller,
          obscureText: hidden,
          decoration: InputDecoration(
              icon: FaIcon(
                icon,
                size: 20,
                color: Colors.deepPurple,
              ),
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
