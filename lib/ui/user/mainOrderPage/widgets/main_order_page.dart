import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/main_order_dialog.dart';
import 'package:site_construct/ui/user/orderDetailsPage/orderDetailsScreen.dart';

class MainOrderPage extends GetView<MainOrderController> {
  const MainOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders Management'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Center(child: Text("Receive Orders", textAlign: TextAlign.center,
                )),
              ),
              Tab(child: Center(child: Text('Order List', textAlign: TextAlign.center))),
              Tab(child: Center(child: Text('Returned Orders', textAlign: TextAlign.center))),
            ],
          ),
        ),
        body: const TabBarView(
          children: [ReceiveOrdersTab(), OrderListTab(), ReturnedOrdersTab()],
        ),
      ),
    );
  }
}

class ReceiveOrdersTab extends GetView<MainOrderController> {
  const ReceiveOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadOrders();
    return Column(
      children: [

        Expanded(
          child: Obx(() {
            final filteredOrders = controller.orders
                .where((order) => order.status=='received')
                .toList();

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
                    color: Colors
                        .green[100], // Received orders differentiated by color
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                        GestureDetector(
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(order: order));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Material: ${order.materialName}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('Supplier: ${order.supplierName}'),
                                const SizedBox(height: 8),
                                Text('Quantity: ${order.quantity}'),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller
                                .deleteOrder(controller.orders.indexOf(order));
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
      ],
    );
  }
}

class OrderListTab extends GetView<MainOrderController> {
  const OrderListTab({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadOrders();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const MainOrderDialog(),
          );
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
                value: controller.selectedSite.value.isEmpty
                    ? null
                    : controller.selectedSite.value,
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
                return order.status=='pending' ||
                    order.status=='approved' &&
                    (controller.selectedSite.value == 'ALL' ||
                        controller.selectedSite.value.isEmpty ||
                        order.siteName == controller.selectedSite.value);
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
                    Color borderColor;
                    Color backgroundColor;

                    switch (order.status) {
                      case 'approved':
                        borderColor = Colors.green;
                        backgroundColor = Colors.white;
                        break;
                      case 'pending':
                        borderColor = Colors.blue;
                        backgroundColor = Colors.white;
                        break;
                      default:
                        borderColor = Colors.grey;
                        backgroundColor = Colors.white;
                        break;
                    }

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => OrderDetailsScreen(order: order));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text('Supplier: ${order.supplierName}'),
                                    const SizedBox(height: 8),
                                    Text('Quantity: ${order.quantity}'),
                                    const SizedBox(height: 8),
                                    Text('Site: ${order.siteName}'),
                                    const SizedBox(height: 8),
                                    Text('Status: ${order.status}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.deleteOrder(
                                      controller.orders.indexOf(order));
                                },
                              ),
                            ],
                          ),
                        ),
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
class ReturnedOrdersTab extends GetView<MainOrderController> {
  const ReturnedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Expanded(
          child: Obx(() {
            final filteredOrders =
                controller.orders.where((order) => order.status=='returned').toList();

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
                    color: Colors
                        .red[100], // Returned orders differentiated by color
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                        GestureDetector(
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(order: order));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Material: ${order.materialName}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('Supplier: ${order.supplierName}'),
                                const SizedBox(height: 8),
                                Text('Quantity: ${order.quantity}'),
                                const SizedBox(height: 8),
                                Text(
                                    'Returned Quantity: ${order.returnedQuantity}'),
                                const SizedBox(height: 8),
                                Text('Site: ${order.siteName}'),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller
                                .deleteOrder(controller.orders.indexOf(order));
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                controller.showReturnDialog();
              },
              child: const Text('Return Orders'),
            ),
          ),
        ),
      ],
    );
  }
}
