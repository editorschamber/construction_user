import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import '../controller/main_order_controller.dart';

class ReturnOrderDialog extends GetView<MainOrderController> {
  final Order order;

  ReturnOrderDialog({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Return Order Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Material: ${order.materialName}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Quantity: ${order.quantity}'),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Site: ${order.siteName}'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(
                  () => Column(
                children: [
                  ListTile(
                    title: const Text('Full Return'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: controller.isFullReturn.value,
                      onChanged: (bool? value) {
                        controller.isFullReturn(value ?? true);
                        if (value == true) {
                          controller.partialReturnQuantityController.clear();
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Partial Return'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: controller.isFullReturn.value,
                      onChanged: (bool? value) {
                        controller.isFullReturn(value ?? true);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Obx(
                  () => Visibility(
                visible: !controller.isFullReturn.value,
                child: TextField(
                  controller: controller.partialReturnQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Partial Return Quantity'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.returnReasonController,
              decoration: const InputDecoration(labelText: 'Return Reason'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
            controller.clearControllers();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (controller.isFullReturn.value) {
              // controller.returnOrder(order); // Full return
              Get.back(result: true);
            } else {
              int? partialQuantity = int.tryParse(controller.partialReturnQuantityController.text);

              if (partialQuantity != null && partialQuantity > 0) {
                if (partialQuantity > int.parse(order.quantity)) {
                  Get.snackbar(
                    'Error',
                    'Partial return quantity cannot exceed the available quantity of ${order.quantity}.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                    borderRadius: 10,
                    margin: const EdgeInsets.all(16),
                    icon: const Icon(Icons.error, color: Colors.white),
                    duration: const Duration(seconds: 3),
                    animationDuration: const Duration(milliseconds: 500),
                    barBlur: 10,
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                  );

                  return;
                }

                controller.returnOrder(order, isFullReturn: false, partialQuantity: partialQuantity);
                // Partial return
              } else {

                Get.snackbar(
                  'Error',
                  'Please enter a valid quantity for partial return.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  borderRadius: 10,
                  margin: const EdgeInsets.all(16),
                  icon: const Icon(Icons.error, color: Colors.white),
                  duration: const Duration(seconds: 3),
                  animationDuration: const Duration(milliseconds: 500),
                  barBlur: 10,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                );
                return;
              }
            }
          },
          child: const Text('Return Order'),
        ),
      ],
    );
  }
}