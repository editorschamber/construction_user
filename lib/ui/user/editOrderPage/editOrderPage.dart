import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class EditOrderPage extends GetView<MainOrderController> {
  final Order order;

  const EditOrderPage({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    final MainOrderController controller = Get.find();

    // Temporary variables to hold updated values
    String? materialName = order.materialName;
    String? supplierName = order.supplierName;
    String? quantity = order.quantity;
    String? siteName = order.siteName;
    String? status = order.status;
    DateTime? expectedDeliveryDate = order.expectedDeliveryDate;

    bool? materialCheck = order.materialCheck ?? false;
    bool? packagingCheck = order.packagingCheck ?? false;
    bool? quantityCheck = order.quantityCheck ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Order Details'),
      ),
      body: Obx(()=>
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (order.imagePath.isNotEmpty)
                    Expanded(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: Image.file(
                            File(order.imagePath.replaceFirst('File: ', '')),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Material Name
                  DropdownButtonFormField<String>(
                    value: materialName,
                    decoration: const InputDecoration(labelText: 'Material'),
                    items: controller.materials.value.map((String material) {
                      return DropdownMenuItem<String>(
                        value: material,
                        child: Text(material),
                      );
                    }).toList(),
                    onChanged: (value) {
                      materialName = value;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Supplier Name
                  TextFormField(
                    initialValue: supplierName,
                    decoration: const InputDecoration(labelText: 'Supplier'),
                    onChanged: (value) {
                      supplierName = value;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Quantity
                  TextFormField(
                    initialValue: quantity,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      quantity = value;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Site Name
                  DropdownButtonFormField<String>(
                    value: order.siteName,
                    onChanged: (value) {
                      controller.updateOrderMaterial(order.id!, value ?? '');
                    },
                    items: controller.sites.map((site) {
                      return DropdownMenuItem<String>(
                        value: site.siteName,
                        child: Text(site.siteName),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Site',
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Status
                  TextFormField(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: 'Status'),
                    onChanged: (value) {
                      status = value;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Expected Delivery Date
                  TextFormField(
                    initialValue: expectedDeliveryDate?.toString().split(' ')[0],
                    decoration: const InputDecoration(labelText: 'Expected Delivery Date'),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: expectedDeliveryDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != expectedDeliveryDate) {
                        expectedDeliveryDate = picked;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),

                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        final updatedOrder = Order(
                          id: order.id,
                          materialName: materialName!,
                          supplierName: supplierName!,
                          quantity: quantity!,
                          siteName: siteName,
                          status: status!,
                          orderCreateDate: order.orderCreateDate,
                          expectedDeliveryDate: expectedDeliveryDate,
                          imagePath: order.imagePath,
                          returnedQuantity: order.returnedQuantity,
                          materialCheck: materialCheck,
                          packagingCheck: packagingCheck,
                          quantityCheck: quantityCheck,
                        );

                        controller.updateOrderById(order.id!, updatedOrder);
                        controller.updater();
                        Get.back();
                      },
                      child: const Text('Save Details'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}