import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/order_controller.dart';

class OrderDialog extends GetView<OrderController> {
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
              decoration: InputDecoration(
                labelText: 'Material Name',
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',

              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addOrder();
                Get.back();
              },
              child: Text('Add Order'),
            ),
          ],
        ),
      ),
    );
  }
}
