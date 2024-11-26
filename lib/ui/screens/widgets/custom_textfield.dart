import 'package:flutter/material.dart';
import 'package:plant/constants.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController controller; // Add a controller

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    required this.controller, // Require controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Bind the controller
      obscureText: obscureText, // Use the correct obscureText value
      style: TextStyle(
        color: Constants.blackColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: Constants.blackColor.withOpacity(.3),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Constants.blackColor.withOpacity(.5),
        ),
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
}