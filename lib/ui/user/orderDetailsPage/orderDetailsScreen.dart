import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/editOrderPage/editOrderPage.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/return_order_dialog.dart';

class OrderDetailsScreen extends GetView<MainOrderController> {
  final int index;
  final Order order;
  final String tabType;

  const OrderDetailsScreen(
      {required this.index,
      required this.order,
      required this.tabType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (order.imagePath.isNotEmpty)
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Image.file(
                        File(order.imagePath.replaceFirst('File: ',
                            '')), // Remove the 'File: ' prefix if present
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Material: ${controller.orders[index].materialName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text('Order ID: ${controller.orders[index].id}'),
                const SizedBox(height: 8),
                Text('Supplier: ${controller.orders[index].supplierName}'),
                const SizedBox(height: 8),
                Text('Quantity: ${controller.orders[index].quantity}'),
                const SizedBox(height: 8),
                Text('Site: ${controller.orders[index].siteName}'),
                const SizedBox(height: 8),
                Text('Status: ${controller.orders[index].status}'),
                const SizedBox(height: 8),
                Text(
                    'Order date: ${DateFormat('dd-MM-yyyy').format(order.orderCreateDate!)}'),
                const SizedBox(height: 8),
                Text(
                    'Expected Delivery Date: ${DateFormat('dd-MM-yyyy').format(controller.orders[index].expectedDeliveryDate!)}'),
                const SizedBox(height: 8),
                if (tabType == 'orderList')
                  Text(
                      'Instructions: ${controller.orders[index].instructions}'),

                if (tabType == 'returnedOrder')
                  Text('Return Reason: ${controller.orders[index].reason}'),
                const SizedBox(height: 16),
                if (tabType == 'receiveOrder')
                  Column(
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors.green;
                                    }
                                    return Colors.grey;
                                  },
                                ),
                                checkColor: WidgetStateProperty.all(
                                    Colors.white), // Checkmark color
                              ),
                            ),
                            child: Checkbox(
                              value: order.materialCheck ?? false,
                              onChanged: null, // Read-only
                            ),
                          ),
                          const Text('Material Check'),
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors
                                          .green; // Background color when checked
                                    }
                                    return Colors
                                        .grey; // Default color when unchecked
                                  },
                                ),
                                checkColor: WidgetStateProperty.all(
                                    Colors.white), // Checkmark color
                              ),
                            ),
                            child: Checkbox(
                              value: order.packagingCheck ?? false,
                              onChanged: null, // Read-only
                            ),
                          ),
                          const Text('Packaging Check'),
                        ],
                      ),
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors
                                          .green; // Background color when checked
                                    }
                                    return Colors
                                        .grey; // Default color when unchecked
                                  },
                                ),
                                checkColor: WidgetStateProperty.all(
                                    Colors.white), // Checkmark color
                              ),
                            ),
                            child: Checkbox(
                              value: order.quantityCheck ?? false,
                              onChanged: null, // Read-only
                            ),
                          ),
                          const Text('Quantity Check'),
                        ],
                      ),
                    ],
                  ),
                if (tabType == 'orderList')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          controller.pickImageFromCamera(order);
                          // Open the ReceiveOrderDialog first with the existing order
                          final result = await Get.dialog<bool>(
                              ReceiveOrderDialog(order: order));

                          // Proceed only if the "Add Order" button was clicked
                          if (result == true) {
                            Get.snackbar(
                                'Received', 'The order is now received',
                                backgroundColor: Colors.greenAccent.shade200);
                            order.status = "received";
                            controller.updateOrderById(order.id!, order);
                            controller.updater();
                          }
                        },
                        child: const Text('Confirm',
                            style: TextStyle(color: Colors.green)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Get.to(() => EditOrderPage(order: order));
                          controller.updater();
                          controller.update;
                        },
                        child: const Text('Edit Order',
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                if (tabType == 'receiveOrder')
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Get.dialog<bool>(ReturnOrderDialog(
                          order: order,
                        ));
                        if (result == true) {
                          Get.snackbar('Return', 'The order is now returned',
                              backgroundColor: Colors.red.shade200);
                          order.status = "returned";
                          controller.updateOrderById(order.id!, order);
                          controller.update();
                        }


                      },
                      child: const Text('Return Order',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
