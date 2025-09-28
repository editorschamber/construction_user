import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield1 extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final double? width;
  final TextEditingController? password;
  Widget? prefixIcon;

  CustomTextfield1(
      {super.key,
      this.hintText,
      this.icon,
      this.password,
      this.width,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 320,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Enter Your Password",
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
                prefixIcon: prefixIcon,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
