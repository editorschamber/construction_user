import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/add_order_page.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/main_order_page.dart';
import 'controller/main_order_controller.dart';

class MainOrderScreen extends GetView<MainOrderController> {
  const MainOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return MainOrderPage();
      }),
    );
  }
}
