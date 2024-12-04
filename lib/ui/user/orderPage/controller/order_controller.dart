import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';

import '../../../../core/notifiers/selectedSiteNotifier.dart';
import '../../homeScreen/home_controller.dart';

class OrderController extends GetxController {
  final box = GetStorage();
  var orders = <Order>[].obs;
  var materialNameController = TextEditingController();
  var quantityController = TextEditingController();
  var selectedSupplier = ''.obs;
  var selectedSite = ''.obs;
  var sites = <Site>[].obs;
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();
  int _orderIdCounter = 0; // ID counter for orders

  List<Order> defaultOrders = [];
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();

  @override
  void onInit() {
    siteNotifier.addListener(() {
      if(siteNotifier.value != null){
        loadOrders();
      }
    });
    super.onInit();
    log("onINITTTTTT");
    loadOrders();
    loadOrderIdCounter();
    orders.addAll(defaultOrders);
    loadSites();
  }

  void loadOrderIdCounter() {
    _orderIdCounter = box.read('orderIdCounter') ?? 0;
  }

  void saveOrderIdCounter() {
    box.write('orderIdCounter', _orderIdCounter);
  }

  void loadOrders() {
    List<Order> storedOrders = (box.read<List>('orders') as List?)
        ?.map((orderJson) => Order.fromJson(orderJson))
        .toList() ??
        defaultOrders;
    // orders.value = storedOrders;
    // orders.value = storedOrders.map((e) => Order.fromJson(e)).toList();
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
  void addOrder({bool isReceivedOrder = false}) {
    bool hasImage = pickedImage != null;
    bool hasMaterial = materialNameController.text.isNotEmpty;
    bool hasQuantity = quantityController.text.isNotEmpty;
    bool hasSite = selectedSite.value.isNotEmpty;

    if (hasImage || (hasMaterial && hasQuantity)) {
      // _orderIdCounter++;
      final order = Order(// Assign incrementing ID
        status: 'pending',
        materialName: hasMaterial ? materialNameController.text : "",
        supplier: selectedSupplier.value,
        quantity: double.tryParse(quantityController.text),
        imagePath: hasImage ? pickedImage!.path : "",
        siteId: siteNotifier.value,
      );

      orders.add(order);
      saveOrders();
      saveOrderIdCounter(); // Save the updated counter
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
        status: '',
        materialName: hasMaterial ? materialNameController.text : "",
        supplierName: selectedSupplier.value,
        quantity: double.tryParse(quantityController.text),
        imagePath: hasImage ? pickedImage!.path : "",
        siteName: selectedSite.value
      );

      orders.add(order);
      saveOrders();
      saveOrderIdCounter(); // Save the updated counter
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
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        pickedImage = File(result.files.single.path!);
        log(result.files.single.path!.toString());
        log(pickedImage!.path.split('/').last.toString());
      }
    } catch (e) {
      log("Error picking file: $e");
    }
  }

  void clearControllers() {
    materialNameController.clear();
    quantityController.clear();
    selectedSupplier.value = '';
    selectedSite.value = '';
    pickedImage = null;
  }
}