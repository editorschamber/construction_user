import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:site_construct/core/data/orderModel.dart';

import '../controller/main_order_controller.dart';

class ReturnOrderDialog extends GetView<MainOrderController> {
  final Order order;

  ReturnOrderDialog({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Return Order Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Displaying Material Name, Quantity, and Site as text fields with default values
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Material: ${order.materialName}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Quantity: ${order.quantity}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Site: ${order.siteName}'),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.returnReasonController,
            decoration: const InputDecoration(labelText: 'Return Reason'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false); // Close the dialog and return false
            controller.clearControllers(); // Clear controllers if canceled
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            controller.returnOrder(order); // Call returnOrder to handle the return process
            Get.back(result: true); // Close the dialog and return true
          },
          child: const Text('Return Order'),
        ),
      ],
    );
  }
}