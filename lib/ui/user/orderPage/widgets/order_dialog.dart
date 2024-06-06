import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/order_controller.dart';

class OrderDialog extends GetView<OrderController> {
  const OrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller.materialNameController,
              decoration: const InputDecoration(
                labelText: 'Material Name',
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return DropdownButton<String>(
                value: controller.selectedSupplier.value,
                onChanged: (String? newValue) {
                  controller.selectedSupplier.value = newValue!;
                },
                items: <String>['Supplier A', 'Supplier B', 'Supplier C']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addOrder();
                Get.back();
              },
              child: const Text('Add Order'),
            ),
          ],
        ),
      ),
    );
  }
}
