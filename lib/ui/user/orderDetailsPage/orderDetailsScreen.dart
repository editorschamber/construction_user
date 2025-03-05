import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/return_order_dialog.dart';
import 'package:site_construct/ui/user/editOrderPage/editOrderPage.dart';

class OrderDetailsScreen extends GetView<MainOrderController> {
  final int index;
  final Order order;
  final String tabType;

  const OrderDetailsScreen({
    required this.index,
    required this.order,
    required this.tabType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  if (controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .imagePath !=
                          null &&
                      controller.orders
                          .firstWhere((element) => element.id == order.id)
                          .imagePath
                          .isNotEmpty)
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          // child: Image.file(
                          //   File(controller.orders
                          //       .firstWhere((element) => element.id == order.id)
                          //       .imagePath
                          //       .replaceFirst('File: ', '')),
                          //   height: 200,
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          // ),

                          child: controller.base64ToImage(controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .imagePath ??
                              '')),
                    ),
                  const SizedBox(height: 16),

                  // Order Details Card
                  _buildSectionCard(
                    title: "Order Information",
                    children: [
                      _buildDetailRow(
                          'Material:',
                          controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .materialName),
                      _buildDetailRow(
                          'Order ID:',
                          controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .id),
                      // _buildDetailRow(
                      //   'Created on',
                      //   DateFormat('dd-MMM-yyyy').format(controller.orders
                      //       .firstWhere((element) => element.id == order.id)
                      //       .expectedDeliveryDate!),
                      // ),
                      _buildDetailRow(
                          'Supplier:',
                          controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .supplierName),
                      _buildDetailRow(
                          'Quantity:',
                          controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .quantity),
                      _buildDetailRow(
                          'Site:',
                          controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .siteName),
                      if (controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              'returned' ||
                          controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              'partially')
                        _buildDetailRow(
                            'Returned Quantity:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .returnedQuantity),
                      _buildDetailRow(
                        'Order Date:',
                        DateFormat('dd-MMM-yyyy').format(controller.orders
                            .firstWhere((element) => element.id == order.id)
                            .orderCreateDate!),
                      ),
                      _buildDetailRow(
                        'Expected Delivery:',
                        DateFormat('dd-MMM-yyyy').format(controller.orders
                            .firstWhere((element) => element.id == order.id)
                            .expectedDeliveryDate!),
                      ),
                      if (tabType == 'orderList')
                        _buildDetailRow(
                            'Instructions:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .instruction),
                      if (controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .status ==
                          'returned')
                        _buildDetailRow(
                            'Return Reason:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .returnReason),
                    ],
                  ),

                  _buildSectionCard(
                    title: "Order Review & Approval",
                    children: [
                      _buildDetailRow(
                          'Created by:',
                          controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .createdByUser
                              ?.displayName),
                      if (controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "approved" ||
                          controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "received" ||
                          controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "partially")
                        _buildDetailRow(
                            'Approved By:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .approvedByUser
                                ?.displayName),
                      if (controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "received" ||
                          controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "partially")
                        _buildDetailRow(
                            'Received By:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .receivedByUser
                                ?.displayName),
                      if (controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "returned" ||
                          controller.orders
                                  .firstWhere(
                                      (element) => element.id == order.id)
                                  .status ==
                              "partially")
                        _buildDetailRow(
                            'Returned By:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .returnedByUser
                                ?.displayName),
                      if (controller.orders
                              .firstWhere((element) => element.id == order.id)
                              .status ==
                          "rejected")
                        _buildDetailRow(
                            'Rejected By:',
                            controller.orders
                                .firstWhere((element) => element.id == order.id)
                                .rejectedByUser
                                ?.displayName),
                    ],
                  ),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(
                              'Status:',
                              _getStatusLabel(controller.orders
                                      .firstWhere(
                                          (element) => element.id == order.id)
                                      .status!)
                                  .capitalizeFirst)
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // // Status Section
                  // _buildSectionCard(
                  //   title: "Status",
                  //   children: [
                  //     Row(
                  //       children: [
                  //         ,
                  //         // const SizedBox(width: 16),
                  //         // Text(
                  //         //   '(${_getStatusLabel(controller.orders
                  //         //       .firstWhere((element) => element.id == order.id)
                  //         //       .status!)})',
                  //         //   style: const TextStyle(color: Colors.grey),
                  //         // ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  //
                  // const SizedBox(height: 16),

                  // Quality Check Section
                  if (controller.orders
                          .firstWhere((element) => element.id == order.id)
                          .status ==
                      'received')
                    _buildSectionCard(
                      title: "Quality Checks",
                      children: [
                        _buildQualityCheckRow('Material Check', true),
                        _buildQualityCheckRow('Packaging Check', true),
                        _buildQualityCheckRow('Quantity Check', true),
                        // _buildQualityCheckRow('Material Check', controller.orders
                        //     .firstWhere((element) => element.id == order.id)
                        //     .qualityCheck),
                        // _buildQualityCheckRow('Packaging Check', controller.orders
                        //     .firstWhere((element) => element.id == order.id)
                        //     .qualityCheck),
                        // _buildQualityCheckRow('Quantity Check', controller.orders
                        //     .firstWhere((element) => element.id == order.id)
                        //     .quantityCheck),
                      ],
                    ),

                  const SizedBox(height: 16),

                  // Action Buttons Section
                  _buildActionSection(context),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value?.toString() ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityCheckRow(String label, bool? value) {
    return Row(
      children: [
        Checkbox(
          value: value ?? false,
          activeColor: Colors.green,
          onChanged: null,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (controller.orders
                  .firstWhere((element) => element.id == order.id)
                  .status ==
              'approved')
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Get.dialog<bool>(ReceiveOrderDialog(
                    order: controller.orders
                        .firstWhere((element) => element.id == order.id)));
                if (result == true) {
                  controller.orders
                      .firstWhere((element) => element.id == order.id)
                      .status = 'received';
                  // controller.markAsReceived(
                  //     controller.orders.firstWhere((element) => element.id ==
                  //         order.id));
                  controller.updater();
                  Get.back();
                  Get.snackbar(
                    'Order Received',
                    'The order has been successfully received.',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                }
              },
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text(
                'Receive Order',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          if (controller.orders
                  .firstWhere((element) => element.id == order.id)
                  .status ==
              'pending')
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => EditOrderPage(
                    order: controller.orders
                        .firstWhere((element) => element.id == order.id)));
                controller.updater();
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                'Edit Order',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          if (order.status == 'received' || order.status == "partially")
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Get.dialog<bool>(
                  ReturnOrderDialog(order: order),
                );
                if (result == true) {
                  order.status = 'returned';
                  // controller.updateOrderById(order.id!, order);
                  controller.updater();
                }
                Get.back();
              },
              icon: const Icon(Icons.reply, color: Colors.white),
              label: const Text(
                'Return Order',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.blueAccent;
      case 'returned':
      case 'partially':
        return Colors.redAccent;
      default:
        return Colors.lightGreen;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'approved':
        return 'Approved';
      case 'pending':
        return 'Pending Approval';
      case 'returned':
        return 'Order Returned';
      case 'partially':
        return 'Partially Returned';
      default:
        return 'Status Unknown';
    }
  }
}
