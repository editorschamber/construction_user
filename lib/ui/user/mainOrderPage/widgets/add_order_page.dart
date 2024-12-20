import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/core/models/supplierData.dart';
import '../../../../core/models/matarialData.dart';
import '../../homeScreen/home_controller.dart';
import '../controller/main_order_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddOrderPage extends StatelessWidget {
  AddOrderPage({super.key});

  final HomeController homeController = Get.put(HomeController());
  final MainOrderController orderController = Get.put(MainOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order'),
      ),
      body: Obx(() {
        return homeController.isLoading.value ? const Center(child: CircularProgressIndicator()) : Padding(
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
                      flex: 3,
                      child: Obx(() {
                        return DropdownButton<SupplierData?>(
                          hint: Text(orderController
                              .selectedSupplier.value?.supplierName ??
                              'Select Supplier'),
                          value: orderController.selectedSupplier.value,
                          onChanged: (newValue) {
                            print(newValue?.toJson());
                            if (newValue != null) {
                              orderController.selectedSupplier.value = newValue;
                              orderController.update();
                            }
                          },
                          items: orderController.suppliers.value
                              .map((supplier) => DropdownMenuItem<SupplierData?>(
                            value: supplier,
                            child: Text(supplier.supplierName ?? ""),
                          ))
                              .toList(),
                        );
                      }),
                    ),
                    Expanded(
                      flex: 2,
                      child: Obx(() {
                        return DropdownButton<Sites>(
                          hint: Text(
                              homeController.selectedSite?.value.siteName ??
                                  'Select Site'),
                          value: homeController.selectedSite?.value,
                          onChanged: (newValue) {
                            print(newValue?.toJson());
                            if (newValue != null) {
                              orderController.selectedSite?.value = newValue;
                              orderController.update();
                            }
                          },
                          items: homeController.siteModel.value.data
                              ?.map((Sites site) {
                            return DropdownMenuItem<Sites>(
                              value: site,
                              child: Text(site.siteName ?? ""),
                            );
                          }).toList(),
                        );
                      }),
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
                                controller: input.expectedDeliveryDateController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'Expected Delivery Date',
                                  hintText: 'Select Date',
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                    input.expectedDeliveryDate.value ??
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
        );
      }),
    );
  }

  void _showMaterialsBottomSheet(BuildContext context, dynamic input) {
    if (orderController.materials.isEmpty == true) {
      print("Materials list is empty");
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  constraints: BoxConstraints(minHeight: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: orderController.materials.value.map((material) {
                      return ListTile(
                        title: Text(material.materialName ?? ""),
                        onTap: () {
                          input.selectedMaterial.value = material.materialName;
                          input.searchController.text = material.materialName;
                          Get.back();
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
