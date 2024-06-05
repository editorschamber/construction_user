import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/orderPage/widgets/order_dialog.dart';
import 'package:site_construct/ui/user/orderPage/widgets/order_page.dart';

import 'controller/order_controller.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: Container(padding:EdgeInsets.symmetric(horizontal: 20,vertical: 15),child: OrderPage()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(OrderDialog() as Widget);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
