import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/core/data/staticData.dart';
import 'package:site_construct/ui/user/homeScreen/home_controller.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class AvailableStock extends StatelessWidget {
  final Sites? site;
  final HomeController homeController;

  const AvailableStock(
      {super.key, required this.site, required this.homeController});

  @override
  Widget build(BuildContext context) {
    if (site == null) return Container(); // Handle null case

    return Obx(() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available Stock',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Get.to(ViewAllScreen(siteName: site!.siteName,
                      homeController: homeController));
                },
                child: const Text('View All'),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: homeController.filteredReceivedOrders.map((material) {
                return StockCard(
                  title: material.materialName ?? "",
                  quantity: material.quantity.toString(),
                  icon: Icons.inventory,
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}

class StockCard extends StatelessWidget {
  final String title;
  final String quantity;
  final IconData icon;

  const StockCard(
      {super.key, required this.title, required this.quantity, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 50, color: Colors.deepPurple.shade400),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(quantity,
              style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}

class ViewAllScreen extends StatelessWidget {
  final String? siteName;
  final HomeController homeController;

  const ViewAllScreen(
      {super.key, required this.siteName, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View All Stock')),
      body: Obx(() {
        return ListView.builder(
          itemCount: homeController.filteredReceivedOrders.length,
          itemBuilder: (context, index) {
            final material = homeController.filteredReceivedOrders[index];
            return StockCard(
              title: "${material.materialName}",
              quantity: material.quantity.toString(),
              icon: Icons.inventory,
            );
          },
        );
      }),
    );
  }
}