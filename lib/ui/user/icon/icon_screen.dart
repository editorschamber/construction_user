import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/icon_page.dart';

class IconScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IconPage(),
    );
  }
}
