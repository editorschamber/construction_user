import 'package:flutter/material.dart';
import 'package:site_construct/constrant/custom_color.dart';

class CustomButton extends StatelessWidget {
  final double buttonRadius;
  final double height;
  final double? width;
  final Color? buttonColor;
  final Color? textColor;
  final String buttonText;
  final VoidCallback onTap;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton({
    super.key,
    this.buttonRadius = 25,
    this.height = 50,
    this.width = 100,
    this.borderRadius,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style:  TextStyle(fontFamily: 'Poppins', color: textColor ),
          ),
        ),
      ),
    );
  }
}
