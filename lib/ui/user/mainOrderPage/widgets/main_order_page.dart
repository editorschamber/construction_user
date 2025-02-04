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
      length: 5,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(
                child: Center(
                    child: Text(
                  "Received",
                  textAlign: TextAlign.center,
                )),
              ),
              Tab(
                  child: Center(
                      child: Text('New / Pending Orders',
                          textAlign: TextAlign.center))),
              Tab(
                  child: Center(
                      child: Text('Approved', textAlign: TextAlign.center))),
              Tab(
                  child: Center(
                      child: Text('Returned', textAlign: TextAlign.center))),
              Tab(
                  child: Center(
                      child: Text('Rejected', textAlign: TextAlign.center))),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
                onRefresh: () async {
                  controller.loadOrders();
                },
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ReceiveOrdersTab()),
            RefreshIndicator(
                onRefresh: () async {
                  controller.loadOrders();
                },
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : OrderListTab()),
            RefreshIndicator(
                onRefresh: () async {
                  controller.loadOrders();
                },
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ApprovedListTab()),
            RefreshIndicator(
                onRefresh: () async {
                  controller.loadOrders();
                },
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ReturnedOrdersTab()),
            RefreshIndicator(
                onRefresh: () async {
                  controller.loadOrders();
                },
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : RejectedOrdersTab()),
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
    // controller.loadOrders();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Expanded(
              child: Obx(() {
                final filteredOrders = controller.orders
                    .where((order) =>
                        order.status == 'received' ||
                        order.status == "partially")
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
                              Text(
                                'Order ID: ${order.id} ${order.status == "partially" ? "(Partially Returned)" : ""}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Qty: ${order.status == "partially" ? ((order.quantity ?? 0) - (order.returnedQuantity ?? 0)) : order.quantity} ${order.unit}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                            ],
                          ),
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(
                                index: controller.orders.indexOf(order),
                                order: order,
                                tabType: 'receiveOrder'));
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

class OrderListTab extends GetView<MainOrderController> {
  const OrderListTab({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.loadOrders();
    final TextEditingController searchController = TextEditingController();
    DateTime? selectedDate;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddOrderPage());
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
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
                        controller.filterDate.value = selectedDate!;
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
                  final statusMatch = order.status == 'pending';
                  final siteMatch =
                      order.siteName?.toLowerCase().contains(query) ?? false;
                  final materialMatch =
                      order.materialName?.toLowerCase().contains(query) ??
                          false;
                  final dateMatch = dateFilter == null ||
                      (order.orderCreateDate != null &&
                          order.orderCreateDate!
                                  .toLocal()
                                  .toString()
                                  .substring(0, 10) ==
                              dateFilter.toLocal().toString().substring(0, 10));
                  return statusMatch &&
                      (siteMatch || materialMatch) &&
                      dateMatch;
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
                                'Order ID: ${order.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Qty: ${order.quantity} ${order.unit}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: ${order.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                            ],
                          ),
                          trailing: Wrap(
                            spacing: 8,
                            // space between the chip and delete icon
                            children: [
                              Chip(
                                label: Text(
                                  order.status!.capitalizeFirst!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: order.status == 'approved'
                                    ? Colors.green
                                    : Colors.blueAccent,
                              ),
                              if (order.status == 'pending')
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    controller.deleteOrder(
                                        controller.orders.indexOf(order));
                                  },
                                ),
                              if (order.status == 'approved')
                                const SizedBox(
                                  width: 40,
                                )
                            ],
                          ),
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(
                                index: controller.orders.indexOf(order),
                                order: controller.orders.firstWhere(
                                    (element) => element.id == order.id),
                                tabType: 'orderList'));
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

class ApprovedListTab extends GetView<MainOrderController> {
  const ApprovedListTab({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.loadOrders();
    final TextEditingController searchController = TextEditingController();
    DateTime? selectedDate;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddOrderPage());
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
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
                        controller.filterDate.value = selectedDate!;
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
                  final statusMatch = order.status == 'approved';
                  final siteMatch =
                      order.siteName?.toLowerCase().contains(query) ?? false;
                  final materialMatch =
                      order.materialName?.toLowerCase().contains(query) ??
                          false;
                  final dateMatch = dateFilter == null ||
                      (order.orderCreateDate != null &&
                          order.orderCreateDate!
                                  .toLocal()
                                  .toString()
                                  .substring(0, 10) ==
                              dateFilter.toLocal().toString().substring(0, 10));
                  return statusMatch &&
                      (siteMatch || materialMatch) &&
                      dateMatch;
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
                                'Order ID: ${order.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Qty: ${order.quantity} ${order.unit}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Price: ${order.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                            ],
                          ),
                          trailing: Wrap(
                            spacing: 8,
                            // space between the chip and delete icon
                            children: [
                              Chip(
                                label: Text(
                                  order.status!.capitalizeFirst!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: order.status == 'approved'
                                    ? Colors.green
                                    : Colors.blueAccent,
                              ),
                              if (order.status == 'pending')
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    controller.deleteOrder(
                                        controller.orders.indexOf(order));
                                  },
                                ),
                              if (order.status == 'approved')
                                const SizedBox(
                                  width: 40,
                                )
                            ],
                          ),
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(
                                index: controller.orders.indexOf(order),
                                order: controller.orders.firstWhere(
                                    (element) => element.id == order.id),
                                tabType: 'orderList'));
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
    // controller.loadOrders();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Expanded(
              child: Obx(() {
                final filteredOrders = controller.orders
                    .where((order) => (order.status == 'returned' ||
                        order.status == "partially"))
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
                          color: Colors.orange[100],
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID: ${order.id} ${order.status == "partially" ? "(Partially Returned)" : ""}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Returned Qty: ${order.returnedQuantity} ${order.unit}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                            ],
                          ),
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(
                                index: controller.orders.indexOf(order),
                                order: order,
                                tabType: 'returnedOrder'));
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

class RejectedOrdersTab extends GetView<MainOrderController> {
  const RejectedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.loadOrders();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Expanded(
              child: Obx(() {
                final filteredOrders = controller.orders
                    .where((order) => (order.status == 'rejected'))
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
                          color: Colors.redAccent.withValues(alpha: 0.2),
                          border: Border.all(color: Colors.redAccent, width: 2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID: ${order.id} ${order.status == "partially" ? "(Partially Returned)" : ""}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Material: ${order.materialName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Returned Qty: ${order.returnedQuantity} ${order.unit}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Supplier: ${order.supplierName}'),
                            ],
                          ),
                          onTap: () {
                            Get.to(() => OrderDetailsScreen(
                                index: controller.orders.indexOf(order),
                                order: order,
                                tabType: 'returnedOrder'));
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
