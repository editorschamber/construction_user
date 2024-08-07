import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';
import '../widgets/return_order_dialog.dart';

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
  int _orderIdCounter = 0; // ID counter for orders

  List<Order> defaultOrders = [
    Order(
      id: '1',
      materialName: "Brick",
      supplierName: 'Hinduja',
      quantity: '100',
      imagePath: '',
      siteName: "Site 1",
      returnedQuantity: '',
      status: 'pending',
    ),
    Order(
      id: '2',
      materialName: "Brick",
      supplierName: 'Hinduja',
      quantity: '100',
      imagePath: '',
      siteName: "Site 1",
      returnedQuantity: '',
      status: 'approved',
    ),
    Order(
      id: '3',
      materialName: "Sand",
      supplierName: 'Malviya',
      quantity: '10',
      imagePath: '',
      siteName: "Site 2",
      returnedQuantity: '5',
      status: 'received',
    ),
    Order(
      id: '4',
      materialName: "Cement",
      supplierName: 'Malviya',
      quantity: '10',
      imagePath: '',
      siteName: "Site 2",
      returnedQuantity: '',
      status: 'returned',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    log("onINITTTTTT");
    loadOrders();
    loadOrderIdCounter();
    orders.addAll(defaultOrders);
    loadSites();
  }

  void updater(){
    loadOrders();
    update();
  }

  List<Order> retrieveOrders() {
    final box = GetStorage();
    final List<dynamic> jsonOrders = box.read('orders') ?? [];
    return jsonOrders.map((json) => Order.fromJson(json)).toList();
  }

  Order? getOrderById(String orderId) {
    final orders = retrieveOrders();
    try {
      return orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null; // Return null if no order is found with the given ID
    }
  }

  void updateOrderById(String id, Order updatedOrder) {
    int index = orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      orders[index] = updatedOrder;
      saveOrders();
    } else {
      Get.snackbar("Order with id $id not found.",'');
    }
  }

  void loadOrderIdCounter() {
    _orderIdCounter = box.read('orderIdCounter') ?? 0;
  }

  void saveOrderIdCounter() {
    box.write('orderIdCounter', _orderIdCounter);
    update();
  }

  void showReturnOrderDialog() {
    Get.dialog(const ReturnOrderDialog());
  }

  void addReturnedOrder(Order order) {
    orders.add(order);
    update();
  }

  void partialReturnOrder(int index, String quantity) {
    orders[index].returnedQuantity += quantity;
    orders[index].status = 'returned';
  }

  void fullReturnOrder(int index) {
    orders[index].returnedQuantity = orders[index].quantity;
    orders[index].quantity = 'Full';
    orders[index].status = 'returned';
  }

  void loadOrders() {
    List<Order>? storedOrders = (box.read<List>('orders') as List?)
        ?.map((orderJson) => Order.fromJson(orderJson))
        .toList();
    if(storedOrders?.length==0){
      orders.addAll(defaultOrders);
      saveOrders();
      loadOrders();
      update();
    }
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

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImage = File(image.path);
        log(image.path.toString());
        log(pickedImage!.path.split('/').last.toString());
        receiveOrderDialog();
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

  void receiveOrderDialog() {
    Get.dialog(
      ReceiveOrderDialog(),
    );
  }

  void showReturnDialog({bool isReceivedOrder = false}) {
    Get.dialog(
      const ReturnOrderDialog(),
    );
  }

  void addOrder({String status = 'pending'}) {
    bool hasImage = pickedImage != null;
    bool hasMaterial = materialNameController.text.isNotEmpty;
    bool hasQuantity = quantityController.text.isNotEmpty;
    bool hasSite = selectedSite.value.isNotEmpty;

    if (hasImage || (hasMaterial && hasQuantity)) {
      _orderIdCounter++;
      final order = Order(
        id: _orderIdCounter.toString(), // Assign incrementing ID
        status: status,
        materialName: hasMaterial ? materialNameController.text : "",
        supplierName: selectedSupplier.value,
        quantity: hasQuantity ? quantityController.text : "",
        imagePath: hasImage ? pickedImage!.path : "",
        siteName: selectedSite.value, // New field
        returnedQuantity: '',
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
      _orderIdCounter++;
      final order = Order(
        id: _orderIdCounter.toString(), // Assign incrementing ID
        status: 'returned',
        materialName: hasMaterial ? materialNameController.text : "",
        supplierName: selectedSupplier.value,
        quantity: hasQuantity ? quantityController.text : "",
        imagePath: hasImage ? pickedImage!.path : "",
        siteName: selectedSite.value, // New field
        returnedQuantity: '',
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