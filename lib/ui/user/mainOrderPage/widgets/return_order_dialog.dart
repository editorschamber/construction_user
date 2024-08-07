import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
class ReturnOrderDialog extends GetView<MainOrderController> {
  const ReturnOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    //   title: const Text('Return Order'),
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       TextField(
    //         decoration: const InputDecoration(hintText: 'Material Name'),
    //         onChanged: (value) {
    //           // Handle material name input
    //         },
    //       ),
    //       TextField(
    //         decoration: const InputDecoration(hintText: 'Supplier Name'),
    //         onChanged: (value) {
    //           // Handle supplier name input
    //         },
    //       ),
    //       TextField(
    //         decoration: const InputDecoration(hintText: 'Quantity'),
    //         keyboardType: TextInputType.number,
    //         onChanged: (value) {
    //           // Handle quantity input
    //         },
    //       ),
    //       TextField(
    //         decoration: const InputDecoration(hintText: 'Returned Quantity'),
    //         keyboardType: TextInputType.number,
    //         onChanged: (value) {
    //           // Handle returned quantity input
    //         },
    //       ),
    //     ],
    //   ),
    //   actions: [
    //     TextButton(
    //       onPressed: () {
    //         Get.back();
    //       },
    //       child: const Text('Cancel'),
    //     ),
    //     ElevatedButton(
    //       onPressed: () {
    //         // Implement logic to add the returned order
    //         final newOrder = Order(
    //           materialName: 'Material Name',
    //           supplierName: 'Supplier Name',
    //           quantity: '',
    //           returnedQuantity: '',
    //           isReturn: true,
    //           imagePath: '',
    //           siteName: '',
    //           status: ''
    //         );
    //         controller.addReturnedOrder(newOrder);
    //         Get.back();
    //       },
    //       child: const Text('Return'),
    //     ),
    //   ],
    // );

    return AlertDialog(
      title: const Text('Return Order Details'),
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
            controller.returnOrder(isReceivedOrder: false);
          },
          child: const Text('Add Order'),
        ),
      ],
    );
  }
}