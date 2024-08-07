import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';

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

  List<Order> defaultOrders = [
    Order(
        materialName: "Brick",
        supplierName: 'Hinduja',
        quantity: '100',
        imagePath: '',
        siteName: "Site 1",
        isReturn: false,
        returnedQuantity: '',
        status: 'pending'
    ),
    Order(
        materialName: "Brick",
        supplierName: 'Hinduja',
        quantity: '100',
        imagePath: '',
        siteName: "Site 1",
        isReturn: false,
        returnedQuantity: '',
        status: 'approved'
    ),
    Order(
        materialName: "Sand",
        supplierName: 'Malviya',
        quantity: '10',
        imagePath: '',
        siteName: "Site 2",
        isReturn: true,
        returnedQuantity: '5',
        status: ''
    ),
    Order(
        materialName: "Cement",
        supplierName: 'Malviya',
        quantity: '10',
        imagePath: '',
        siteName: "Site 2",
        isReturn: false,
        returnedQuantity: '',
        isReceivedOrder: true,
        status: ''
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    log("onINITTTTTT");

    loadOrders();
    // orders.addAll(defaultOrders);
    loadSites();
  }

  void addOrder({bool isReceivedOrder = false}) {
    bool hasImage = pickedImage != null;
    bool hasMaterial = materialNameController.text.isNotEmpty;
    bool hasQuantity = quantityController.text.isNotEmpty;
    bool hasSite = selectedSite.value.isNotEmpty;

    if (hasImage || (hasMaterial && hasQuantity)) {
      final order = Order(
          status: 'pending',
          materialName: hasMaterial ? materialNameController.text : "",
          supplierName: selectedSupplier.value,
          quantity: hasQuantity ? quantityController.text : "",
          imagePath: hasImage ? pickedImage!.path : "",
          isReceivedOrder: isReceivedOrder,
          siteName: selectedSite.value, // New field
          isReturn: false,
          returnedQuantity: '');

      orders.add(order);
      saveOrders();
      clearControllers();
    } else {
      log("Order cannot be added. Please provide either an image, material, quantity, and site.");
    }
  }


  void loadOrders() {

    List<Order> storedOrders = (box.read<List>('orders') as List?)
        ?.map((orderJson) => Order.fromJson(orderJson))
        .toList() ??
        defaultOrders;
    orders.value = storedOrders;
    // orders.value = storedOrders.map((e) => Order.fromJson(e)).toList();
  }

  void saveOrders() {
    box.write('orders', orders.map((e) => e.toJson()).toList());
    log("Saved");
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
      log("Error picking file: ${e}");
    }
  }

  void clearControllers() {
    materialNameController.clear();
    quantityController.clear();
    selectedSupplier.value = '';
    selectedSite.value = ''; // New field
    pickedImage = null;
  }
}
