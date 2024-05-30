import 'package:flutter/material.dart';

class CustomEnterNumber extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final double? width;
  final TextEditingController? countryCode;
  final TextEditingController? numberController;

  const CustomEnterNumber({
    super.key,
    this.hintText,
    this.icon,
    this.countryCode,
    this.numberController,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
          ),
          child: TextField(
            controller: countryCode,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Expanded(
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
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Enter Your Number",
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                ),
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
