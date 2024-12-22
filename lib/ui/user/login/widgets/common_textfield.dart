import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController password;
  final Widget? prefixIcon;

  const CustomTextfield({
    Key? key,
    required this.password,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: password,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
  }
}

