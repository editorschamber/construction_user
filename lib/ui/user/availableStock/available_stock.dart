import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/core/data/staticData.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';

class AvailableStock extends StatelessWidget {
  final Site? site;
  final MainOrderController orderController;

  const AvailableStock({super.key, required this.site, required this.orderController});

  @override
  Widget build(BuildContext context) {
    if (site == null) return Container(); // Handle null case

    return Obx(() {
      final siteStock = orderController.filteredReceivedOrders ?? [];

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available Stock', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Get.to(ViewAllScreen(siteName: site!.siteName));
                },
                child: const Text('View All'),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: siteStock.map((material) {
                return StockCard(
                  title: material.materialName,
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

  const StockCard({super.key, required this.title, required this.quantity, required this.icon});

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
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(quantity, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}

class ViewAllScreen extends StatelessWidget {
  final String? siteName;

  const ViewAllScreen({super.key, required this.siteName});

  @override
  Widget build(BuildContext context) {
    final siteStock = StaticData.siteMaterials[siteName] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('View All Stock')),
      body: ListView.builder(
        itemCount: siteStock.length,
        itemBuilder: (context, index) {
          final material = siteStock[index];
          return StockCard(
            title: material.name,
            quantity: material.quantity.toString(),
            icon: Icons.inventory,
          );
        },
      ),
    );
  }
}