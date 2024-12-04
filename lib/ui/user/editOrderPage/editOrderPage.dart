import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/core/models/matarialData.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class EditOrderPage extends GetView<MainOrderController> {
  final Order order;

  const EditOrderPage({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    final MainOrderController controller = Get.find();

    // Temporary variables to hold updated values
    Materials? materialName = Materials();
    String? supplierName = order.supplierName;
    String? quantity = "${order.quantity}";
    String? siteName = order.siteName;
    String? status = order.status;
    String? instructions = order.instructions;
    DateTime? expectedDeliveryDate = order.expectedDeliveryDate;

    bool? materialCheck = order.qualityCheck ?? false;
    bool? packagingCheck = order.qualityCheck ?? false;
    bool? quantityCheck = order.quantityCheck ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Order Details'),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (order.imagePath != null && order.imagePath.isNotEmpty)
                    Expanded(
                      child: Center(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Image.file(
                            File(order.imagePath.replaceFirst('File: ', '')),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Material Name
                  DropdownButtonFormField<Materials>(
                    value: materialName,
                    decoration: const InputDecoration(labelText: 'Material'),
                    items: controller.materials.value.map((Materials material) {
                      return DropdownMenuItem<Materials>(
                        value: material,
                        child: Text(material.materialName ?? ""),
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
                  DropdownButtonFormField<Sites>(
                    value: controller.sites.value.data
                        ?.firstWhereOrNull((site) => site.id == order.siteId),
                    onChanged: (value) {
                      controller.updateOrderMaterial(order.id!, value);
                    },
                    items: controller.sites.value.data?.map((site) {
                      return DropdownMenuItem<Sites>(
                        value: site,
                        child: Text(site.siteName ?? ""),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Site',
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Expected Delivery Date
                  TextFormField(
                    initialValue:
                        expectedDeliveryDate?.toString().split(' ')[0],
                    decoration: const InputDecoration(
                        labelText: 'Expected Delivery Date'),
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
                  TextFormField(
                    initialValue: instructions,
                    decoration:
                        const InputDecoration(labelText: 'Instructions'),
                    onChanged: (value) {
                      instructions = value;
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
                            materialName: materialName?.materialName ?? "",
                            supplierName: supplierName!,
                            quantity: double.tryParse(quantity ?? "0"),
                            siteName: siteName,
                            status: status!,
                            orderCreateDate: order.orderCreateDate,
                            expectedDeliveryDate: expectedDeliveryDate,
                            imagePath: order.imagePath,
                            returnedQuantity: order.returnedQuantity,
                            qualityCheck: materialCheck,
                            quantityCheck: quantityCheck,
                            instructions: instructions);

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
