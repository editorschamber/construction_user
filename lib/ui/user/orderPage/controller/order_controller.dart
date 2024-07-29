import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class OrderController extends GetxController {
  var orders = <Order>[].obs;
  var images = <File>[].obs;

  var materialNameController = TextEditingController();
  var quantityController = TextEditingController();
  var selectedSupplier = ''.obs;

  void addOrder() {
    orders.add(
      Order(
        materialName: materialNameController.text,
        supplierName: selectedSupplier.value,
        quantity: quantityController.text,
      ),
    );
    clearControllers();
  }

  void clearControllers() {
    materialNameController.clear();
    quantityController.clear();
    selectedSupplier.value = '';
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        images.add(File(result.files.single.path!));
      }
    } catch (e) {
      // Handle errors if needed
      print("Error picking file: $e");
    }
  }
}

class Order {
  final String materialName;
  final String supplierName;
  final String quantity;

  Order({
    required this.materialName,
    required this.supplierName,
    required this.quantity,
  });
}
