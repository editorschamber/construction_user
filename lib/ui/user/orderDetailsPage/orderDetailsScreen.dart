import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class OrderDetailsScreen extends GetView<MainOrderController> {
  final Order order;

  const OrderDetailsScreen({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (order.imagePath.isNotEmpty)
              Center(
                child: Image.file(
                  File(order.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'Material: ${order.materialName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Order ID: ${order.id}'),
            const SizedBox(height: 8),
            Text('Supplier: ${order.supplierName}'),
            const SizedBox(height: 8),
            Text('Quantity: ${order.quantity}'),
            const SizedBox(height: 8),
            Text('Site: ${order.siteName}'),
            const SizedBox(height: 8),
            Text('Status: ${order.status}'),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Receive Order Button
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Received', 'The order is now received',
                    backgroundColor: Colors.greenAccent.shade200);
                    order.status = "received";
                    controller.updateOrderById(order.id, order);
                    controller.updater();
                  },
                  child: const Text('Receive Order',style: TextStyle(color: Colors.green)),
                ),

                const SizedBox(
                  width: 25,
                ),

                //Return Order Button
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Return', 'The order is now returned',
                    backgroundColor: Colors.red.shade200);
                    order.status = "returned";
                    controller.updateOrderById(order.id, order);
                    controller.update();
                  },
                  child: const Text('Return Order',style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}