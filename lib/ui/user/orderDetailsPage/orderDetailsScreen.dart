import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';

class OrderDetailsScreen extends GetView<MainOrderController> {
  final Order order;
  final String tabType;

  const OrderDetailsScreen({required this.order, required this.tabType, super.key});

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
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.file(
                      File(order.imagePath.replaceFirst('File: ', '')), // Remove the 'File: ' prefix if present
                      fit: BoxFit.cover,
                    ),
                  ),
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
            const SizedBox(height: 8),
            Text('Order date: ${order.orderCreateDate}'),
            const SizedBox(height: 8),
            Text('Expected Delivery Date: ${order.expectedDeliveryDate}'),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: order.materialCheck ?? false,
                  onChanged: null, // Read-only
                ),
                const Text('Material Check'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: order.packagingCheck ?? false,
                  onChanged: null, // Read-only
                ),
                const Text('Packaging Check'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: order.quantityCheck ?? false,
                  onChanged: null, // Read-only
                ),
                const Text('Quantity Check'),
              ],
            ),

            if (tabType == 'orderList')
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    controller.pickImageFromCamera(order);
                    // Open the ReceiveOrderDialog first with the existing order
                    final result = await Get.dialog<bool>(ReceiveOrderDialog(order: order));

                    // Proceed only if the "Add Order" button was clicked
                    if (result == true) {
                      Get.snackbar('Received', 'The order is now received',
                          backgroundColor: Colors.greenAccent.shade200);
                      order.status = "received";
                      controller.updateOrderById(order.id!, order);
                      controller.updater();
                    }
                  },
                  child: const Text('Receive Order', style: TextStyle(color: Colors.green)),
                ),
              ),
            if (tabType == 'receiveOrder')
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Return', 'The order is now returned',
                        backgroundColor: Colors.red.shade200);
                    order.status = "returned";
                    controller.updateOrderById(order.id!, order);
                    controller.update();
                  },
                  child: const Text('Return Order', style: TextStyle(color: Colors.red)),
                ),
              ),


          ],
        ),
      ),
    );
  }
}
