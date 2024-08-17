import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';
import '../widgets/return_order_dialog.dart';

class MainOrderController extends GetxController {
  var filterQuery = ''.obs;
  final instructionsController = TextEditingController();
  final returnReasonController = TextEditingController();

  final box = GetStorage();
  var orders = <Order>[].obs;
  var selectedSupplier = ''.obs;
  var selectedSite = ''.obs;
  var filterSelectedSite = ''.obs;
  var orderInputs =
      <OrderInput>[].obs;
  var sites = <Site>[].obs;
  var materials = <String>[].obs;
  var qualityChecks = <String, bool>{
    'materialQuality': false,
    'quantityAccuracy': false,
    'packaging': false,
  }.obs; // Added for quality checks
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();
  int _orderIdCounter = 0; // ID counter for orders

  List<Order> defaultOrders = [
    Order(
        id: '1',
        materialName: "Bricks",
        supplierName: 'Hinduja',
        quantity: '100',
        imagePath: '',
        siteName: "Site 1",
        returnedQuantity: '',
        status: 'pending',
        orderCreateDate: DateTime.now(),
        expectedDeliveryDate: DateTime.now(),
        instructions: 'Wrap the bricks in plastic, leave at door',
        reason: 'Quality is not good'),
    Order(
        id: '2',
        materialName: "Bricks",
        supplierName: 'Hinduja',
        quantity: '100',
        imagePath: '',
        siteName: "Site 1",
        returnedQuantity: '',
        status: 'approved',
        orderCreateDate: DateTime.now(),
        expectedDeliveryDate: DateTime.now(),
        instructions: 'Wrap the bricks in plastic, leave at door',
        reason: 'Quality is not good'),
    Order(
        id: '3',
        materialName: "Sand",
        supplierName: 'Malviya',
        quantity: '10',
        imagePath: '',
        siteName: "Site 2",
        returnedQuantity: '5',
        status: 'received',
        orderCreateDate: DateTime.now(),
        expectedDeliveryDate: DateTime.now(),
        instructions: 'Wrap the bricks in plastic, leave at door',
        reason: 'Quality is not good'),
    Order(
        id: '4',
        materialName: "Cement",
        supplierName: 'Malviya',
        quantity: '10',
        imagePath: '',
        siteName: "Site 2",
        returnedQuantity: '',
        status: 'returned',
        orderCreateDate: DateTime.now(),
        expectedDeliveryDate: DateTime.now().add(Duration(days: 5)),
        instructions: 'Wrap the bricks in plastic, leave at door',
        reason: 'Quality is not good'),
  ];

  // List of random 10 construction materials
  List<String> defaultMaterials = [
    'Cement',
    'Steel',
    'Bricks',
    'Gravel',
    'Sand',
    'Concrete',
    'Lime',
    'Clay',
    'Timber',
    'Glass',
  ];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
    loadOrderIdCounter();
    orders.addAll(defaultOrders);
    loadSites();
    materials.clear();
    materials.addAll(defaultMaterials); // Add default materials to the list
    addOrderInput(); // Initialize with one set of input fields
    update();
  }

  List<Order> get filteredOrders {
    final query = filterQuery.value.toLowerCase();
    return orders.where((order) {
      final siteMatch = order.siteName.toLowerCase().contains(query);
      final materialMatch = order.materialName.toLowerCase().contains(query);
      final statusMatch = order.status == 'pending' || order.status == 'approved';
      return (siteMatch || materialMatch) && statusMatch;
    }).toList();
  }

  void addOrderInput() {
    orderInputs.add(OrderInput());
  }

  void removeOrderInput(int index) {
    if (orderInputs.length > 1) {
      orderInputs.removeAt(index);
    }
  }

  void updater() {
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
      loadOrders();
    } else {
      Get.snackbar("Order with id $id not found.", '');
    }
  }

  void loadOrderIdCounter() {
    _orderIdCounter = box.read('orderIdCounter') ?? 0;
  }

  void saveOrderIdCounter() {
    box.write('orderIdCounter', _orderIdCounter);
    update();
  }

  // void showReturnOrderDialog() {
  //   Get.dialog(const ReturnOrderDialog());
  // }

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
    if (storedOrders?.length == 0) {
      orders.addAll(defaultOrders);
      saveOrders();
      loadOrders();
      update();
    }
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

  Future<void> pickImageFromCamera(Order order) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedImage = File(image.path);
        log(image.path);
        order.imagePath = image.path;
        updateOrderById(order.id!, order);
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
      }
    } catch (e) {
      log("Error picking image: $e");
    }
  }

  void receiveOrderDialog() {
    Get.dialog(
      ReceiveOrderDialog(order: orders.first),
    );
  }

  // void showReturnDialog({bool isReceivedOrder = false}) {
  //   Get.dialog(
  //     const ReturnOrderDialog(),
  //   );
  // }

  void addOrder({String status = 'pending'}) {
    for (final input in orderInputs) {
      bool hasMaterial = input.selectedMaterial.value.isNotEmpty;
      bool hasQuantity = input.quantityController.text.isNotEmpty;
      if (hasMaterial && hasQuantity) {
        _orderIdCounter++;
        final order = Order(
          id: _orderIdCounter.toString(),
          status: status,
          materialName: input.selectedMaterial.value,
          supplierName: selectedSupplier.value,
          quantity: input.quantityController.text,
          siteName: selectedSite.value,
          orderCreateDate: input.orderCreateDate.value,
          expectedDeliveryDate: input.expectedDeliveryDate.value,
          imagePath: '',
          returnedQuantity: '',
          instructions: instructionsController.text,
          reason: returnReasonController.text, // Ensure reason is stored
        );

        if (qualityChecks['materialQuality'] == true) {
          log("Material Quality Checked");
        }
        if (qualityChecks['quantityAccuracy'] == true) {
          log("Quantity Accuracy Checked");
        }
        if (qualityChecks['packaging'] == true) {
          log("Packaging Checked");
        }

        orders.add(order);
      }
    }
    saveOrders();
    saveOrderIdCounter();
    clearControllers();
  }

  void returnOrder(Order oldOrder) {
    _orderIdCounter++;
    final order = Order(
      id: oldOrder.id,
      status: 'returned',
      materialName: oldOrder.materialName,
      supplierName: oldOrder.supplierName,
      quantity: oldOrder.quantity,
      siteName: oldOrder.siteName,
      orderCreateDate: oldOrder.orderCreateDate,
      expectedDeliveryDate: oldOrder.expectedDeliveryDate,
      returnedQuantity: 'FULL',
      imagePath: '',
      reason: returnReasonController.text, // Store the return reason here
    );

    orders.add(order);

    saveOrders();
    saveOrderIdCounter();
    clearControllers();
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
      }
    } catch (e) {
      log("Error picking file: $e");
    }
  }

  void updateOrderMaterial(String orderId, String newMaterial) {
    int index = orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      orders[index].materialName = newMaterial;
      saveOrders(); // Save the updated orders list
      update(); // Notify the UI to refresh
    } else {
      Get.snackbar("Order Not Found", "No order found with ID $orderId");
    }
  }

  void clearControllers() {
    selectedSupplier.value = '';
    selectedSite.value = '';
    orderInputs.clear();
    qualityChecks.updateAll((key, value) => false);
    addOrderInput();
  }
}

// Class to handle individual order input
// Class to handle individual order input
class OrderInput {
  var selectedMaterial = ''.obs;
  var quantityController = TextEditingController();
  var orderCreateDate = Rx<DateTime>(DateTime.now());
  var expectedDeliveryDate = Rx<DateTime?>(null);
  var expectedDeliveryDateController = TextEditingController();

  // Adding the searchController and filteredMaterials
  var searchController = TextEditingController();
  var filteredMaterials = <String>[].obs;

  // Ensure you dispose the controllers when no longer needed
  void dispose() {
    quantityController.dispose();
    expectedDeliveryDateController.dispose();
    searchController.dispose();
  }
}
