import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/core/data/site.dart';
import '../controller/main_order_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddOrderPage extends StatelessWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<MainOrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(() {
                      final distinctSuppliers = orderController.orders
                          .map((order) => order.supplierName)
                          .toSet()
                          .toList();

                      return DropdownButton<String>(
                        hint: const Text('Supplier'),
                        value: orderController.selectedSupplier.value.isNotEmpty
                            ? orderController.selectedSupplier.value
                            : null,
                        onChanged: (newValue) {
                          orderController.selectedSupplier.value = newValue!;
                        },
                        items: distinctSuppliers
                            .map((supplier) => DropdownMenuItem<String>(
                          value: supplier,
                          child: Text(supplier),
                        ))
                            .toList(),
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Obx(() {
                      return DropdownButton<String>(
                        hint: const Text("Site"),
                        value: orderController.selectedSite.value.isEmpty
                            ? null
                            : orderController.selectedSite.value,
                        items: orderController.sites
                            .map<DropdownMenuItem<String>>((Site site) {
                          return DropdownMenuItem<String>(
                            value: site.siteName,
                            child: Text(site.siteName),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            orderController.selectedSite.value = newValue;
                          }
                        },
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      orderController.addOrderInput();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() {
                return Column(
                  children: orderController.orderInputs.map((input) {
                    final index = orderController.orderInputs.indexOf(input);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showMaterialsBottomSheet(
                                          context,
                                          input,
                                          orderController.materials,
                                        );
                                      },
                                      child: AbsorbPointer(
                                        child: TextField(
                                          controller: input.searchController,
                                          decoration: const InputDecoration(
                                            hintText: 'Select Material',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (orderController.orderInputs.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    orderController.removeOrderInput(index);
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          TextField(
                            controller: input.quantityController,
                            decoration:
                            const InputDecoration(labelText: 'Quantity'),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            input.expectedDeliveryDateController.text =
                            input.expectedDeliveryDate.value != null
                                ? DateFormat('yyyy-MM-dd').format(
                                input.expectedDeliveryDate.value!)
                                : '';
                            return TextField(
                              controller:
                              input.expectedDeliveryDateController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Expected Delivery Date',
                                hintText: 'Select Date',
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: input.expectedDeliveryDate
                                      .value ??
                                      DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  input.expectedDeliveryDate.value = pickedDate;
                                  input.expectedDeliveryDateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 10),
              TextField(
                controller: orderController.instructionsController,
                decoration: const InputDecoration(labelText: 'Instructions'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  orderController.addOrder();
                  Get.back();
                },
                child: const Text('Submit Orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaterialsBottomSheet(BuildContext context, dynamic input, List<String> materials) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // Allows the bottom sheet to cover more vertical space
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,  // Enables the sheet to be dragged and resized
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: materials.map((material) {
                  return ListTile(
                    title: Text(material),
                    onTap: () {
                      input.selectedMaterial.value = material;
                      input.searchController.text = material;
                      Get.back();                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
