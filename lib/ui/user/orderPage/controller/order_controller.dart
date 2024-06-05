import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/oder_model.dart';

class OrderController extends GetxController {
  var orders = <Order>[].obs;
  var selectedSupplier = 'Supplier A'.obs;

  TextEditingController materialNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  void addOrder() {
    final order = Order(
      materialName: materialNameController.text,
      supplierName: selectedSupplier.value,
      quantity: quantityController.text,
    );

    orders.add(order);

    // Clear the text fields after adding
    materialNameController.clear();
    quantityController.clear();
  }
}
