import 'package:flutter/material.dart';

class CustomEnterNumber extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final double? width;
  final TextEditingController? countryCode;
  final TextEditingController? numberController;
  final Widget? prefixIcon;

  const CustomEnterNumber({
    super.key,
    this.hintText,
    this.icon,
    this.countryCode,
    this.numberController,
    this.width,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: numberController,
      keyboardType: TextInputType.phone,
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
        hintText: 'Enter your number',
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
