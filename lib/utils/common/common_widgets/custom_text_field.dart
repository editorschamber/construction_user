import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final double? height;

  const CustomTextField({
    super.key,
    this.hintText,
    this.icon,
    this.controller,
    this.height = 50
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.grey,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
