import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/staticData.dart';

class DailyUsagePage extends StatefulWidget {
  final String? siteName;

  const DailyUsagePage({super.key, required this.siteName});

  @override
  _DailyUsagePageState createState() => _DailyUsagePageState();
}

class _DailyUsagePageState extends State<DailyUsagePage> {
  List<MaterialModel> selectedMaterials = [];
  String? selectedMaterial;
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedMaterials = StaticData.siteMaterials[widget.siteName] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Material Usage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Site Specific Materials"),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: selectedMaterials.length,
                itemBuilder: (context, index) {
                  final material = selectedMaterials[index];
                  return ListTile(
                    title: Text(material.name),
                    subtitle: Text('Available: ${material.quantity}'),
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
              items: selectedMaterials.map((material) {
                return DropdownMenuItem<String>(
                  value: material.name,
                  child: Text(material.name),
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
              onPressed: () {
                final materialName = selectedMaterial;
                final quantityUsed = double.tryParse(quantityController.text);

                if (materialName != null && quantityUsed != null) {
                  setState(() {
                    final material = selectedMaterials.firstWhere(
                          (m) => m.name == materialName,
                      orElse: () => MaterialModel(name: materialName, quantity: 0),
                    );

                    if (material.quantity - quantityUsed < 0) {
                      Get.snackbar(
                        "Error",
                        "Insufficient quantity available.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    } else {
                      material.quantity -= quantityUsed;

                      // Update the observable data
                      StaticData.siteMaterials[widget.siteName]!.firstWhere((m) => m.name == materialName).quantity = material.quantity;

                      Get.snackbar(
                        "Success",
                        "Quantity updated successfully.",
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    }
                  });
                  quantityController.clear();
                }
              },
              child: const Center(child: Text("Add Usage")),
            ),
          ],
        ),
      ),
    );
  }
}