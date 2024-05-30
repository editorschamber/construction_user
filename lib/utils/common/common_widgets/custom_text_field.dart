import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30.0),
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
