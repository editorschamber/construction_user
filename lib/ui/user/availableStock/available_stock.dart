import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableStock extends GetView {
  const AvailableStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Available Stock', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                Get.to(ViewAllScreen());
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              StockCard(title: 'Total Bag', quantity: '42'),
              StockCard(title: 'Total Steel', quantity: '3100/kg'),
              StockCard(title: 'Total Brick', quantity: '3100'),
            ],
          ),
        ),
      ],
    );
  }
}

class StockCard extends StatelessWidget {
  final String title;
  final String quantity;

  const StockCard({super.key, required this.title, required this.quantity});

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
          const Icon(Icons.inventory, size: 50),
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
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stockDetails = [
      {'title': 'Total Bag', 'quantity': '42'},
      {'title': 'Total Steel', 'quantity': '3100/kg'},
      {'title': 'Total Brick', 'quantity': '3100'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('View All Stock')),
      body: ListView.builder(
        itemCount: stockDetails.length,
        itemBuilder: (context, index) {
          return StockCard(
            title: stockDetails[index]['title']!,
            quantity: stockDetails[index]['quantity']!,
          );
        },
      ),
    );
  }
}
