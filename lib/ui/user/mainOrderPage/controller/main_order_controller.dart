import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';

import '../widgets/return_order_dialog.dart';

class Order {
  final String materialName;
  final String supplierName;
  String quantity;
  final String imagePath;
  final bool isReceivedOrder;
  final String siteName;
  bool isReturn;
  String returnedQuantity; // New field

  Order({
    required this.materialName,
    required this.supplierName,
    required this.quantity,
    required this.imagePath,
    this.isReceivedOrder = false,
    required this.siteName,
    required this.isReturn,
    required this.returnedQuantity, // Initialize new field
  });

  Map<String, dynamic> toJson() {
    return {
      'materialName': materialName,
      'supplierName': supplierName,
      'quantity': quantity,
      'imagePath': imagePath,
      'isReceivedOrder': isReceivedOrder,
      'siteName': siteName,
      'isReturn': isReturn,
      'returnedQuantity': returnedQuantity, // Include new field
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      materialName: json['materialName'],
      supplierName: json['supplierName'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
      isReceivedOrder: json['isReceivedOrder'] ?? false,
      siteName: json['siteName'] ?? '',
      isReturn: json['isReturn'],
      returnedQuantity: json['returnedQuantity'] ?? '', // Default value for new field
    );
  }
}

class MainOrderController extends GetxController {
  final box = GetStorage();
  var orders = <Order>[].obs;
  var materialNameController = TextEditingController();
  var quantityController = TextEditingController();
  var selectedSupplier = ''.obs;
  var selectedSite = ''.obs;
  var sites = <Site>[].obs;
  File? pickedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    loadSites();
  }

  void showReturnOrderDialog() {
    Get.dialog(const ReturnOrderDialog());
  }

  void addReturnedOrder(Order order) {
    orders.add(order);
  }

  void partialReturnOrder(int index, String quantity) {
      orders[index].returnedQuantity += quantity;
      orders[index].isReturn = true;
    }




  void fullReturnOrder(int index) {
    orders[index].returnedQuantity = orders[index].quantity;
    orders[index].quantity = 'Full';
    orders[index].isReturn = true;
  }

  void loadOrders() {
    List storedOrders = box.read<List>('orders') ?? [];
    orders.value = storedOrders.map((e) => Order.fromJson(e)).toList();
  }

  void saveOrders() {
    box.write('orders', orders.map((e) => e.toJson()).toList());
  }

  void loadSites() {
    sites.value = [
      Site(
        imageUrl: '',
        siteName: 'ALL',
        siteDetails: '',
        location: '',
      ),
      Site(
        imageUrl: 'assets/img/site1.jpg',
        siteName: 'Site 1',
        siteDetails: 'Details about Site 1',
        location: 'Location 1',
      ),
      Site(
        imageUrl: 'assets/img/site2.jpg',
        siteName: 'Site 2',
        siteDetails: 'Details about Site 2',
        location: 'Location 2',
      ),
      Site(
        imageUrl: 'assets/img/site3.jpg',
        siteName: 'Site 3',
        siteDetails: 'Details about Site 3',
        location: 'Location 3',
      ),
    ];
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImage = File(image.path);
        log(image.path.toString());
        log(pickedImage!.path.split('/').last.toString());
        showOrderDialog(isReceivedOrder: true);
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }
  Future<void> returnOrderPicker() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImage = File(image.path);
        log(image.path.toString());
        log(pickedImage!.path.split('/').last.toString());
        showReturnOrderDialog();
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  void showOrderDialog({bool isReceivedOrder = false}) {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Order Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: materialNameController,
              decoration: const InputDecoration(labelText: 'Material Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            Obx(() {
              return DropdownButton<String>(
                hint: const Text("Select Site"),
                value: selectedSite.value.isEmpty ? null : selectedSite.value,
                items: sites.map((Site site) {
                  return DropdownMenuItem<String>(
                    value: site.siteName,
                    child: Text(site.siteName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedSite.value = newValue;
                  }
                },
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              clearControllers(); // Clear controllers if canceled
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              addOrder(isReceivedOrder: isReceivedOrder);
            },
            child: const Text('Add Order'),
          ),
        ],
      ),
    );
  }
void showReturnDialog({bool isReceivedOrder = false}) {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Order Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: materialNameController,
              decoration: const InputDecoration(labelText: 'Material Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            Obx(() {
              return DropdownButton<String>(
                hint: const Text("Select Site"),
                value: selectedSite.value.isEmpty ? null : selectedSite.value,
                items: sites.map((Site site) {
                  return DropdownMenuItem<String>(
                    value: site.siteName,
                    child: Text(site.siteName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedSite.value = newValue;
                  }
                },
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              clearControllers(); // Clear controllers if canceled
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              returnOrder(isReceivedOrder: false);
            },
            child: const Text('Add Order'),
          ),
        ],
      ),
    );
  }

  void addOrder({bool isReceivedOrder = false}) {
    bool hasImage = pickedImage != null;
    bool hasMaterial = materialNameController.text.isNotEmpty;
    bool hasQuantity = quantityController.text.isNotEmpty;
    bool hasSite = selectedSite.value.isNotEmpty;

    if (hasImage || (hasMaterial && hasQuantity)) {
      final order = Order(
        materialName: hasMaterial ? materialNameController.text : "",
        supplierName: selectedSupplier.value,
        quantity: hasQuantity ? quantityController.text : "",
        imagePath: hasImage ? pickedImage!.path : "",
        isReceivedOrder: isReceivedOrder,
        siteName: selectedSite.value,  // New field
        isReturn: false, returnedQuantity: ''
      );

      orders.add(order);
      saveOrders();
      clearControllers();
    } else {
      log("Order cannot be added. Please provide either an image, material, quantity, and site.");
    }
  }
  void returnOrder({bool isReceivedOrder = false}) {
    bool hasImage = pickedImage != null;
    bool hasMaterial = materialNameController.text.isNotEmpty;
    bool hasQuantity = quantityController.text.isNotEmpty;
    bool hasSite = selectedSite.value.isNotEmpty;

    if (hasImage || (hasMaterial && hasQuantity)) {
      final order = Order(
        materialName: hasMaterial ? materialNameController.text : "",
        supplierName: selectedSupplier.value,
        quantity: hasQuantity ? quantityController.text : "",
        imagePath: hasImage ? pickedImage!.path : "",
        isReceivedOrder: isReceivedOrder,
        siteName: selectedSite.value,  // New field
        isReturn: true,
          returnedQuantity: ''
      );

      orders.add(order);
      saveOrders();
      clearControllers();
    } else {
      log("Order cannot be added. Please provide either an image, material, quantity, and site.");
    }
  }

  void deleteOrder(int index) {
    orders.removeAt(index);
    saveOrders();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        pickedImage = File(result.files.single.path!);
        log(result.files.single.path!.toString());
        log(pickedImage!.path.split('/').last.toString());
      }
    } catch (e) {
      log("Error picking file: ${e}");
    }
  }

  void clearControllers() {
    materialNameController.clear();
    quantityController.clear();
    selectedSupplier.value = '';
    selectedSite.value = '';  // New field
    pickedImage = null;
  }


}