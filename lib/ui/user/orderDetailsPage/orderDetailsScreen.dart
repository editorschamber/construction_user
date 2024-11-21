import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/editOrderPage/editOrderPage.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/main_order_page.dart';
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
          child: Column(
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
                'Material: ${order.materialName}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
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
              Text(
                  'Order date: ${DateFormat('dd-MMM-yyyy').format(order.orderCreateDate!)}'),
              const SizedBox(height: 8),
              Text(
                  'Expected Delivery Date: ${DateFormat('dd-MMM-yyyy').format(order.expectedDeliveryDate!)}'),
              const SizedBox(height: 8),
              if (tabType == 'orderList')
                Text(
                    'Instructions: ${order.instructions}'),
              if (order.status == 'returned')
                Text('Return Reason: ${order.reason}'),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Status:'),
                  // Text('Status: ${order.status}'),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      order.status!.capitalizeFirst!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: order.status == 'approved'
                        ? Colors.green
                        : order.status == 'pending'
                        ? Colors.blue
                        : order.status == 'returned'
                        ? Colors.redAccent
                        : Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 8.0),
                  )
                ],
              ),
              const SizedBox(height: 16),
              if (order.status == 'received')
                Column(
                  children: [
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                              fillColor:
                              MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.green;
                                  }
                                  return Colors.grey;
                                },
                              ),
                              checkColor: MaterialStateProperty.all(
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
                              MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors
                                        .green; // Background color when checked
                                  }
                                  return Colors
                                      .grey; // Default color when unchecked
                                },
                              ),
                              checkColor: MaterialStateProperty.all(
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
                              MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors
                                        .green; // Background color when checked
                                  }
                                  return Colors
                                      .grey; // Default color when unchecked
                                },
                              ),
                              checkColor: MaterialStateProperty.all(
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
              if (order.status == 'approved')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // controller.pickImageFromCamera(order);
                        // Open the ReceiveOrderDialog first with the existing order
                        final result = await Get.dialog<bool>(
                            ReceiveOrderDialog(order: order));

                        // Proceed only if the "Add Order" button was clicked
                        if (result == true) {

                          order.status = "received";
                          controller.markAsReceived(order);
                          controller.updater();
                          Get.back();
                          Get.snackbar(
                            'Order Received',
                            'The order has been successfully received.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            borderRadius: 10,
                            margin: const EdgeInsets.all(16),
                            icon:
                            const Icon(Icons.check, color: Colors.white),
                            duration: const Duration(seconds: 3),
                            animationDuration:
                            const Duration(milliseconds: 500),
                            barBlur: 10,
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal, snackbarStatus: (status){
                                if(status == SnackbarStatus.CLOSED){
                                  order.status = "received";
                                  controller.markAsReceived(order);
                                  controller.updater();
                                  // Get.back();
                                }
                              }
                          );
                        }
                      },
                      child: const Text('Confirm',
                          style: TextStyle(color: Colors.green)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Get.to(() => EditOrderPage(order: order));
                        controller.update();
                      },
                      child: const Text('Edit Order',
                          style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              if (order.status == 'pending')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Get.to(() => EditOrderPage(order: order));
                        controller.updater();
                      },
                      child: const Text('Edit Order',
                          style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              if (order.status == 'received')
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Get.dialog<bool>(ReturnOrderDialog(
                        order: order,
                      ));
                      if (result==true) {
                        order.status = "returned";
                        controller.updateOrderById(order.id!, order);
                        controller.updater();
                      }
                      Get.back();
                    },
                    child: const Text('Return Order',
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
