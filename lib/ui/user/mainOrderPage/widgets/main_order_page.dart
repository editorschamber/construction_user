import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class MainOrderPage extends GetView<MainOrderController> {
  const MainOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Receive Orders'),
              Tab(text: 'Order List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ReceiveOrdersTab(),
            OrderListTab(),
          ],
        ),
      ),
    );
  }
}

class ReceiveOrdersTab extends GetView<MainOrderController> {
  const ReceiveOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                controller.pickImageFromCamera();
              },
              child: const Text('Receive Orders'),
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            final filteredOrders = controller.orders.where((order) => order.isReceivedOrder).toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Card(
                    color: Colors.green[100], // Received orders differentiated by color
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (order.imagePath.isNotEmpty)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.file(
                                            File(order.imagePath),
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text('Close'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.file(
                                  File(order.imagePath),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                              const SizedBox(height: 8),
                              Text('Quantity: ${order.quantity}'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteOrder(controller.orders.indexOf(order));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}

class OrderListTab extends GetView<MainOrderController> {
  const OrderListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action to be performed when the button is pressed
          controller.pickImageFromCamera();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return DropdownButton<String>(
                hint: const Text("Select Site"),
                value: controller.selectedSite.value.isEmpty ? null : controller.selectedSite.value,
                items: controller.sites.map<DropdownMenuItem<String>>((Site site) {
                  return DropdownMenuItem<String>(
                    value: site.siteName,
                    child: Text(site.siteName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedSite.value = newValue;
                  }
                },
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              final filteredOrders = controller.orders.where((order) {
                return !order.isReceivedOrder &&
                    (controller.selectedSite.value == 'ALL' || controller.selectedSite.value.isEmpty || order.siteName == controller.selectedSite.value);
              }).toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Card(
                      color: Colors.blue[100], // Only local storage orders are shown, so only blue color is used
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (order.imagePath.isNotEmpty)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.file(
                                              File(order.imagePath),
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.file(
                                    File(order.imagePath),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Material: ${order.materialName}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('Supplier: ${order.supplierName}'),
                                const SizedBox(height: 8),
                                Text('Quantity: ${order.quantity}'),
                                const SizedBox(height: 8),
                                Text('Site: ${order.siteName}'),  // New field
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteOrder(controller.orders.indexOf(order));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}