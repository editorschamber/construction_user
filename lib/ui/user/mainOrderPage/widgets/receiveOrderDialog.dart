import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:site_construct/core/data/orderModel.dart';

import '../controller/main_order_controller.dart';

class ReceiveOrderDialog extends GetView<MainOrderController> {
  final Order order;

  ReceiveOrderDialog({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Received Order Details'),
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

          // Quality checkboxes
          const SizedBox(height: 16),
          const Text('Quality Checks', style: TextStyle(fontWeight: FontWeight.bold)),
          Obx(() {
            return Column(
              children: [
                CheckboxListTile(
                  title: const Text('Check Material Quality'),
                  value: controller.qualityChecks['materialQuality'],
                  onChanged: (bool? value) {
                    order.materialCheck = value;
                    controller.qualityChecks['materialQuality'] = value ?? false;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Check Quantity Accuracy'),
                  value: controller.qualityChecks['quantityAccuracy'],
                  onChanged: (bool? value) {
                    order.quantityCheck = value;
                    controller.qualityChecks['quantityAccuracy'] = value ?? false;
                  },
                ),
                CheckboxListTile(
                  title: const Text('Check Packaging'),
                  value: controller.qualityChecks['packaging'],
                  onChanged: (bool? value) {
                    order.packagingCheck = value;
                    controller.qualityChecks['packaging'] = value ?? false;
                  },
                ),
              ],
            );
          }),
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
            Get.back(result: true); // Close the dialog and return true
            controller.addOrder(status: 'received');
          },
          child: const Text('Receive Order'),
        ),
      ],
    );
  }
}
