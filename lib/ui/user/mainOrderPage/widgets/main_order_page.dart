import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/add_order_page.dart';
import 'package:site_construct/ui/user/orderDetailsPage/orderDetailsScreen.dart';

class MainOrderPage extends GetView<MainOrderController> {
  const MainOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final filteredOrders = controller.orders
                  .where((order) => order.status == 'received')
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (order.imagePath.isNotEmpty)
                            //   GestureDetector(
                            //     onTap: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) => Dialog(
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(16),
                            //           ),
                            //           child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(16),
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Image.file(
                            //                   File(order.imagePath),
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //                 SizedBox(
                            //                   width: MediaQuery.of(context).size.width,
                            //                   child: TextButton(
                            //                     onPressed: () {
                            //                       Get.back();
                            //                     },
                            //                     child: const Text('Close'),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(12),
                            //       child: Image.file(
                            //         File(order.imagePath),
                            //         width: double.infinity,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            const SizedBox(height: 8),
                            Text(
                              'Material: ${order.materialName}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('Supplier: ${order.supplierName}'),
                            // const SizedBox(height: 8),
                            // Text('Quantity: ${order.quantity}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.deleteOrder(controller.orders.indexOf(order));
                          },
                        ),
                        onTap: () {
                          Get.to(() => OrderDetailsScreen(index: controller.orders.indexOf(order),order: order, tabType: 'receiveOrder'));
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         controller.pickImageFromCamera();
          //       },
          //       child: const Text('Receive Orders'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class OrderListTab extends GetView<MainOrderController> {
  const OrderListTab({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadOrders();
    final TextEditingController searchController = TextEditingController();
    DateTime? selectedDate;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddOrderPage());
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search by Site or Material",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                        ),
                      ),
                      onChanged: (query) {
                        controller.filterQuery.value = query.toLowerCase();
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        controller.filterDate?.value = selectedDate!;
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final query = controller.filterQuery.value;
                final dateFilter = controller.filterDate?.value;
                final filteredOrders = controller.orders.where((order) {
                  final statusMatch = order.status == 'pending' || order.status == 'approved';
                  final siteMatch = order.siteName.toLowerCase().contains(query);
                  final materialMatch = order.materialName.toLowerCase().contains(query);
                  final dateMatch = dateFilter == null ||
                      (order.orderCreateDate != null &&
                          order.orderCreateDate!.toLocal().toString().substring(0, 10) ==
                              dateFilter.toLocal().toString().substring(0, 10));
                  return statusMatch && (siteMatch || materialMatch) && dateMatch;
                }).toList();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
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

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteOrder(controller.orders.indexOf(order));
                            },
                          ),
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(index: controller.orders.indexOf(order), order: order, tabType: 'orderList'));
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnedOrdersTab extends GetView<MainOrderController> {
  const ReturnedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadOrders();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final filteredOrders = controller.orders
                  .where((order) => order.status == 'returned')
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (order.imagePath.isNotEmpty)
                            //   GestureDetector(
                            //     onTap: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) => Dialog(
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(16),
                            //           ),
                            //           child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(16),
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Image.file(
                            //                   File(order.imagePath),
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //                 SizedBox(
                            //                   width: MediaQuery.of(context).size.width,
                            //                   child: TextButton(
                            //                     onPressed: () {
                            //                       Get.back();
                            //                     },
                            //                     child: const Text('Close'),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(12),
                            //       child: Image.file(
                            //         File(order.imagePath),
                            //         width: double.infinity,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            const SizedBox(height: 8),
                            Text(
                              'Material: ${order.materialName}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('Supplier: ${order.supplierName}'),
                            // const SizedBox(height: 8),
                            // Text('Quantity: ${order.quantity}'),
                            // const SizedBox(height: 8),
                            // Text('Returned Quantity: ${order.returnedQuantity}'),
                            // const SizedBox(height: 8),
                            // Text('Site: ${order.siteName}'),
                          ],
                        ),
                        onTap: () {
                          Get.to(() => OrderDetailsScreen(index:controller.orders.indexOf(order) ,order: order, tabType: 'returnedOrder'));
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         controller.showReturnOrderDialog();
          //       },
          //       child: const Text('Return Orders'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}