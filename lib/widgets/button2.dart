import 'package:flutter/material.dart';

class CustomGenderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double borderRadius;
  final Color? color;
  final Color? foreGroundColor;
  final Color? borderColor; // Parameter for border color
  final double? borderWidth; // Parameter for border width

  const CustomGenderButton({
    Key? key,
    this.borderColor, // It's nullable so it may not be passed
    this.borderWidth = 1, // Default width is 1 if not passed
    required this.text,
    this.onPressed,
    this.width,
    required this.borderRadius,
    this.color,
    this.foreGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Color(0xFF6418C3),
          foregroundColor: foreGroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            // Use the borderColor if it's not null, otherwise use a default color
            side: BorderSide(
              color: borderColor ??
                  Colors
                      .white, // Default to blue if borderColor is not provided
              width: borderWidth ??
                  1, // Use the provided borderWidth or default to 1
            ),
          ),
        ),
      ),
    );
  }
}
