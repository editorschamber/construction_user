import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class ReturnOrderDialog extends GetView<MainOrderController> {
  const ReturnOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Return Order Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Original single order input fields
          // TextField(
          //   controller: controller.materialNameController,
          //   decoration: const InputDecoration(labelText: 'Material Name'),
          // ),
          // TextField(
          //   controller: controller.quantityController,
          //   decoration: const InputDecoration(labelText: 'Quantity'),
          //   keyboardType: TextInputType.number,
          // ),
          // Obx(() {
          //   return DropdownButton<String>(
          //     hint: const Text("Select Site"),
          //     value: controller.selectedSite.value.isEmpty ? null : controller.selectedSite.value,
          //     items: controller.sites.map((Site site) {
          //       return DropdownMenuItem<String>(
          //         value: site.siteName,
          //         child: Text(site.siteName),
          //       );
          //     }).toList(),
          //     onChanged: (String? newValue) {
          //       if (newValue != null) {
          //         controller.selectedSite.value = newValue;
          //       }
          //     },
          //   );
          // }),

          // Updated multi-order input fields
          Obx(() {
            return Column(
              children: controller.orderInputs.map((input) {
                return Column(
                  children: [
                    TextField(
                      controller: input.quantityController,
                      decoration: const InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      hint: const Text("Select Material"),
                      value: input.selectedMaterial.value.isEmpty
                          ? null
                          : input.selectedMaterial.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          input.selectedMaterial.value = newValue;
                        }
                      },
                      items: controller.materials.map((String material) {
                        return DropdownMenuItem<String>(
                          value: material,
                          child: Text(material),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      hint: const Text("Select Site"),
                      value: controller.selectedSite.value.isEmpty
                          ? null
                          : controller.selectedSite.value,
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
                    ),
                  ],
                );
              }).toList(),
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
          child: const Text('Return Order'),
        ),
      ],
    );
  }
}
