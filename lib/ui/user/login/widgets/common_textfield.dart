import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController password;
  final Widget? prefixIcon;

  const CustomTextfield({
    Key? key,
    required this.password,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true; // Controls password visibility

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.password,
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle visibility
            });
          },
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.white70),
      ),
    );
  }
}