import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/ui/user/orderPage/widgets/order_dialog.dart';
import 'package:site_construct/ui/user/orderPage/widgets/order_page.dart';

import 'controller/order_controller.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
      ),
      body: const OrderPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const OrderDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
