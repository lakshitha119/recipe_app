import 'package:flutter/material.dart';
import 'package:recipe_app/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  IconData icon;
  String label;
  bool obscureText;
  CustomTextField(
      {required this.icon,
      required this.label,
      required this.obscureText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // Add elevation to the container
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: AppColors.contentColorDarkBlue, // Change this color
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.contentColorDarkBlue), // Change this color
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Change this color
          ),
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: AppColors.contentColorDarkBlue,
          ),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: TextInputType.emailAddress,
        obscureText: obscureText,
      ),
    );
  }
}
