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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              if (order.imagePath != null && order.imagePath.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(order.imagePath.replaceFirst('File: ', '')),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Order Details Card
              _buildSectionCard(
                title: "Order Information",
                children: [
                  _buildDetailRow('Material:', order.materialName),
                  _buildDetailRow('Order ID:', order.id),
                  _buildDetailRow('Supplier:', order.supplierName),
                  _buildDetailRow('Quantity:', order.quantity),
                  _buildDetailRow('Site:', order.siteName),
                  if (order.status == 'returned' || order.status == 'partially')
                    _buildDetailRow('Returned Quantity:', order.returnedQuantity),
                  _buildDetailRow(
                    'Order Date:',
                    DateFormat('dd-MMM-yyyy').format(order.orderCreateDate!),
                  ),
                  _buildDetailRow(
                    'Expected Delivery:',
                    DateFormat('dd-MMM-yyyy').format(order.expectedDeliveryDate!),
                  ),
                  if (tabType == 'orderList')
                    _buildDetailRow('Instructions:', order.instructions),
                  if (order.status == 'returned')
                    _buildDetailRow('Return Reason:', order.returnReason),
                ],
              ),

              const SizedBox(height: 16),

              // Status Section
              _buildSectionCard(
                title: "Status",
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          order.status!.capitalizeFirst!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: _getStatusColor(order.status!),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10.0),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '(${_getStatusLabel(order.status!)})',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Quality Check Section
              if (order.status == 'received')
                _buildSectionCard(
                  title: "Quality Checks",
                  children: [
                    _buildQualityCheckRow('Material Check', order.qualityCheck),
                    _buildQualityCheckRow('Packaging Check', order.qualityCheck),
                    _buildQualityCheckRow('Quantity Check', order.quantityCheck),
                  ],
                ),

              const SizedBox(height: 16),

              // Action Buttons Section
              _buildActionSection(context),
            ],
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
          if (order.status == 'approved')
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Get.dialog<bool>(
                    ReceiveOrderDialog(order: order));
                if (result == true) {
                  order.status = 'received';
                  controller.markAsReceived(order);
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
              label: const Text('Mark as Received'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          if (order.status == 'pending')
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => EditOrderPage(order: order));
                controller.updater();
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Edit Order', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          if (order.status == 'received')
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Get.dialog<bool>(
                  ReturnOrderDialog(order: order),
                );
                if (result == true) {
                  order.status = 'returned';
                  controller.updateOrderById(order.id!, order);
                  controller.updater();
                }
                Get.back();
              },
              icon: const Icon(Icons.reply, color: Colors.white),
              label: const Text('Return Order', style: TextStyle(color: Colors.white),),
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