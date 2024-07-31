import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class Order {
  final String materialName;
  final String supplierName;
  final String quantity;
  final String imagePath;

  Order({
    required this.materialName,
    required this.supplierName,
    required this.quantity,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'materialName': materialName,
      'supplierName': supplierName,
      'quantity': quantity,
      'imagePath': imagePath,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      materialName: json['materialName'],
      supplierName: json['supplierName'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
    );
  }
}

class OrderController extends GetxController {
  final box = GetStorage();
  var orders = <Order>[].obs;
  var materialNameController = TextEditingController();
  var quantityController = TextEditingController();
  var selectedSupplier = ''.obs;
  File? pickedImage;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() {
    List storedOrders = box.read<List>('orders') ?? [];
    orders.value = storedOrders.map((e) => Order.fromJson(e)).toList();
  }

  void saveOrders() {
    box.write('orders', orders.map((e) => e.toJson()).toList());
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

  void addOrder() {
    if (pickedImage != null) {
      final order = Order(
        materialName: materialNameController.text,
        supplierName: selectedSupplier.value,
        quantity: quantityController.text,
        imagePath: pickedImage!.path,
      );

      orders.add(order);
      saveOrders();
      clearControllers();
    }
  }

  void deleteOrder(int index) {
    orders.removeAt(index);
    saveOrders();
  }

  void clearControllers() {
    materialNameController.clear();
    quantityController.clear();
    selectedSupplier.value = '';
    pickedImage = null;
  }
}