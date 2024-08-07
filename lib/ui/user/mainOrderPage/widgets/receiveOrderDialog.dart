import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class ReceiveOrderDialog extends GetView<MainOrderController> {
  bool isReceivedOrder;
  ReceiveOrderDialog({super.key, required this.isReceivedOrder});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Received Order Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.materialNameController,
            decoration: const InputDecoration(labelText: 'Material Name'),
          ),
          TextField(
            controller: controller.quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          Obx(() {
            return DropdownButton<String>(
              hint: const Text("Select Site"),
              value: controller.selectedSite.value.isEmpty ? null : controller.selectedSite.value,
              items: controller.sites.map((Site site) {
                return DropdownMenuItem<String>(
                  value: site.siteName,
                  child: Text(site.siteName),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedSite.value = newValue;
                }
              },
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
            controller.clearControllers(); // Clear controllers if canceled
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
            controller.addOrder(isReceivedOrder: isReceivedOrder);
          },
          child: const Text('Add Order'),
        ),
      ],
    );
  }
}