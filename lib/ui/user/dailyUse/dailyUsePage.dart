import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/staticData.dart';
import 'package:site_construct/ui/user/homeScreen/home_controller.dart';

import '../../../core/models/materialQuantity.dart';

class DailyUsagePage extends StatefulWidget {
  final String? siteName;

  const DailyUsagePage({super.key, required this.siteName});

  @override
  _DailyUsagePageState createState() => _DailyUsagePageState();
}

class _DailyUsagePageState extends State<DailyUsagePage> {
  List<MaterialQuantity> selectedMaterials = [];
  String? selectedMaterial;
  final TextEditingController quantityController = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    selectedMaterials = homeController.filteredReceivedOrders ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Material Usage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Site Specific Materials"),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: homeController.filteredReceivedOrders.length,
                  itemBuilder: (context, index) {
                    final material = homeController
                        .filteredReceivedOrders[index];
                    return ListTile(
                      title: Text(material.materialName ?? ""),
                      subtitle: Text('Available: ${material.quantity} ${material
                          .unit}'),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text("Add Daily Usage"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedMaterial,
                hint: const Text("Select Material"),
                items: homeController.filteredReceivedOrders.map((material) {
                  return DropdownMenuItem<String>(
                    value: material.materialName,
                    child: Text(material.materialName ?? ""),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMaterial = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Material Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quantity Used",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final materialName = selectedMaterial;
                  final quantityUsed = double.tryParse(quantityController.text);

                  if (materialName != null && quantityUsed != null &&
                      quantityUsed > 0) {
                    final isUpdated = await homeController.submitDailyUsage(
                      materialName,
                      quantityUsed,
                    );

                    if (isUpdated) {
                      homeController.fetchStockBySiteName();
                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Material usage updated successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      setState(() {
                        quantityController.clear();
                        selectedMaterial = null;
                      });
                    } else {
                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Failed to update material usage."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Please select a material and enter a valid quantity."),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                child: const Center(child: Text("Add Usage")),
              ),
            ],
          );
        }),
      ),
    );
  }
}