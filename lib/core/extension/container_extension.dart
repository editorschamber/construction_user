import 'package:flutter/material.dart';

extension DecorationContainer on Container {
  Container decorate([int? x, double? height, double? width]) {
    return Container(
      padding: padding,
      height: height ?? constraints?.maxHeight ?? 30,
      width: width ?? constraints?.maxWidth,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(x?.toDouble() ?? 12),
      ),
      child: this,
    );
  }
}
