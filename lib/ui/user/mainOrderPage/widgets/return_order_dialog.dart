import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
class ReturnOrderDialog extends GetView<MainOrderController> {
  const ReturnOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Return Order'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'Material Name'),
            onChanged: (value) {
              // Handle material name input
            },
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Supplier Name'),
            onChanged: (value) {
              // Handle supplier name input
            },
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Quantity'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Handle quantity input
            },
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Returned Quantity'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // Handle returned quantity input
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Implement logic to add the returned order
            final newOrder = Order(
              materialName: 'Material Name',
              supplierName: 'Supplier Name',
              quantity: '',
              returnedQuantity: '',
              isReturn: true,
              imagePath: '',
              siteName: '',
            );
            controller.addReturnedOrder(newOrder);
            Get.back();
          },
          child: const Text('Return'),
        ),
      ],
    );
  }
}