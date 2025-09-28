import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconPage extends GetView {
  const IconPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: notificationTile(),
    );
  }

  Widget notificationTile() {
    final List<Map<String, String>> items = [
      {"title": "Site 1 sand order approved", "time": "2m ago"},
      {"title": "Site 2 cement order returned", "time": "10m ago"},
      {"title": "Site 1 sand order created", "time": "1h ago"},
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.notifications),
          title: Text(items[index]["title"]!),
          subtitle: Text(items[index]["time"]!),
          onTap: () {
            // Handle tap
          },
        );
      },
    );
  }
}
