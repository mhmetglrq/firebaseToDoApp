import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/sizes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: vertical10,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: colorWhite,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
