import 'package:flutter/material.dart';
import 'package:site_construct/constrant/custom_color.dart';

extension StyledText on Text {
  Text greyStyled() {
    return Text(
      data ?? '',
      style: const TextStyle(
        fontSize: 12,
        color: CustomColor.lightGrey,
        fontFamily: 'Poppins',
      ),
    );
  }
}
