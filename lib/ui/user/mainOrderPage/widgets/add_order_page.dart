import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/core/models/supplierData.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/image_picker_dialog.dart';

import '../../../../core/models/matarialData.dart';
import '../../homeScreen/home_controller.dart';
import '../controller/main_order_controller.dart';

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
        return homeController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<Sites>(
                                  hint: Text(homeController
                                          .selectedSite?.value.siteName ??
                                      'Select Site'),
                                  value: homeController.selectedSite?.value,
                                  onChanged: (newValue) {
                                    print(newValue?.toJson());
                                    if (newValue != null) {
                                      orderController.selectedSite?.value =
                                          newValue;
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
                                ),
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
                            final index =
                                orderController.orderInputs.indexOf(input);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _showSuppliersBottomSheet(
                                                    context, input);
                                              },
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  controller:
                                                      input.supplierController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'Select Supplier',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                _showMaterialsBottomSheet(
                                                  context,
                                                  input,
                                                );
                                              },
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  controller:
                                                      input.searchController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'Select Material',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (orderController.orderInputs.length >
                                          1)
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            orderController
                                                .removeOrderInput(index);
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: input.quantityController,
                                    decoration: const InputDecoration(
                                        labelText: 'Quantity'),
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
                                                input.expectedDeliveryDate
                                                    .value!)
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
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: input
                                                  .expectedDeliveryDate.value ??
                                              DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2101),
                                        );
                                        if (pickedDate != null) {
                                          input.expectedDeliveryDate.value =
                                              pickedDate;
                                          input.expectedDeliveryDateController
                                                  .text =
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
                        decoration:
                            const InputDecoration(labelText: 'Instructions'),
                      ),
                      // Replace the existing Row for Gallery/Camera buttons with this single button
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ImagePickerDialog(
                                  onImageSelected: (base64Image) {
                                    orderController.setBase64Image(base64Image);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Image selected successfully'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.image,
                              color: Colors.black,
                              size: 20,
                            ),
                            label: const Text(
                              'Pick Image',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 50),
                              backgroundColor: Colors.deepOrange.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          orderController.base64Image != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.check_circle,
                                          color: Colors.green),
                                      SizedBox(width: 8),
                                      Text('Image attached',
                                          style:
                                              TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          orderController.addOrder();
                          Get.back(result: true);
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

  void _showSuppliersBottomSheet(BuildContext context, OrderInput input) {
    if (orderController.suppliers.isEmpty) {
      print("Suppliers list is empty");
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: orderController.suppliers.value
                      .map((SupplierData supplier) {
                    return ListTile(
                      title: Text(supplier.supplierName ?? ""),
                      onTap: () {
                        input.supplierController.text =
                            supplier.supplierName ?? "";
                        input.selectedSupplier.value = supplier;

                        Get.back();
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
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
                  constraints: const BoxConstraints(minHeight: 100),
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
