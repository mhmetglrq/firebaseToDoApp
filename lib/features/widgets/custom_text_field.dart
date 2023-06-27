import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/sizes.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: vertical10,
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: colorWhite,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: colorWhite,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: colorWhite,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
