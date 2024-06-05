import 'package:flutter/material.dart';

class AvailableStock extends StatelessWidget {
  const AvailableStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Available Stock', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                // Navigate to view all screen
              },
              child: Text('View All'),
            ),
          ],
        ),
        SingleChildScrollView(
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
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.inventory, size: 50),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(quantity, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
