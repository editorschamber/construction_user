import 'package:flutter/material.dart';

extension CustomTextExtensions on Text {
  Text customStyle() {
    return Text(
      this.data ?? '',
      style: this.style?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ) ??
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
