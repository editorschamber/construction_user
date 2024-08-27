import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';
import '../widgets/return_order_dialog.dart';

class MainOrderController extends GetxController {
  var filterQuery = ''.obs;
  final instructionsController = TextEditingController();
  final returnReasonController = TextEditingController();
  Rx<DateTime?> filterDate = Rx<DateTime?>(null);
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
  RxBool isFullReturn = false.obs;

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
        orderCreateDate: DateTime.now().subtract(Duration(days: 10)),
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
        orderCreateDate: DateTime.now().subtract(Duration(days: 11)),
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

  TextEditingController partialReturnQuantityController = TextEditingController();

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

      final dateMatch = filterDate.value == null || order.orderCreateDate!.isAfter(filterDate.value!);

      return (siteMatch || materialMatch) && statusMatch && dateMatch;
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

  void returnOrder(Order oldOrder, {bool isFullReturn = true, int? partialQuantity}) async {

    //partial return handling
    if (!isFullReturn && partialQuantity != null) {
      _orderIdCounter++;

      String returnedQuantity = partialQuantity.toString();

      final returnedOrder = Order(
        id: _orderIdCounter.toString(),
        status: 'returned',
        materialName: oldOrder.materialName,
        supplierName: oldOrder.supplierName,
        quantity: returnedQuantity,
        siteName: oldOrder.siteName,
        orderCreateDate: oldOrder.orderCreateDate,
        expectedDeliveryDate: oldOrder.expectedDeliveryDate,
        returnedQuantity: returnedQuantity,
        imagePath: '',
        reason: returnReasonController.text,
      );
      int oldQuantity = int.parse(oldOrder.quantity);
      int newQuantity = oldQuantity - partialQuantity;

      if (newQuantity > 0) {
        oldOrder.quantity = newQuantity.toString();
        orders.add(returnedOrder);
      } else {
        oldOrder.status = 'returned';
      }

      update();
      Get.back();
      Timer(const Duration(seconds: 1), () {
        Get.snackbar(
          'Order Returned',
          'The order is now returned',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
          icon: const Icon(Icons.check, color: Colors.white),
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 500),
          barBlur: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        );
      });


    }

    else if (isFullReturn) {
      oldOrder.status = 'returned';
      Get.back();
      update();
      Timer(const Duration(seconds: 1), () {
        Get.snackbar(
          'Order Returned',
          'The order is now returned',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(16),
          icon: const Icon(Icons.check, color: Colors.white),
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 500),
          barBlur: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        );
      });
      Timer(const Duration(seconds: 1), () {
        updater();
        update();
      });
    }

    update();
    saveOrders();
    saveOrderIdCounter();
    clearControllers();
  }

  void deleteOrder(int index) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Confirm Delete',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Are you sure you want to delete this order?'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      orders.removeAt(index);
                      saveOrders();
                      Get.back();

                      Get.snackbar(
                        'Order Deleted',
                        'The order has been successfully deleted.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(16),
                        icon: const Icon(Icons.delete, color: Colors.white),
                        duration: const Duration(seconds: 3),
                        animationDuration: const Duration(milliseconds: 500),
                        barBlur: 10,
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                      );
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
