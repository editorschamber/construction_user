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
import 'package:site_construct/apiServices/homeService.dart';
import 'package:site_construct/apiServices/orderService.dart';
import 'package:site_construct/apiServices/supplierService.dart';
import 'package:site_construct/core/data/orderModel.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/core/models/matarialData.dart';
import 'package:site_construct/core/models/supplierData.dart';
import 'package:site_construct/core/notifiers/selectedSiteNotifier.dart';
import 'package:site_construct/ui/user/mainOrderPage/widgets/receiveOrderDialog.dart';
import '../../../../apiServices/stockService.dart';
import '../../../../core/data/sitesModel.dart';
import '../../../../core/models/materialQuantity.dart';
import '../widgets/return_order_dialog.dart';

class MainOrderController extends GetxController {
  var filterQuery = ''.obs;
  final instructionsController = TextEditingController();
  final returnReasonController = TextEditingController();
  Rx<DateTime?> filterDate = Rx<DateTime?>(null);
  final box = GetStorage();
  RxList<Order> orders = <Order>[].obs;
  Rx<SupplierData?> selectedSupplier = Rx<SupplierData?>(null);
  Rx<SitesModel> sites = SitesModel().obs;
  Rx<Sites>? selectedSite = Sites().obs;
  var filterSelectedSite = ''.obs;
  var orderInputs = <OrderInput>[].obs;
  RxList<Materials> materials = <Materials>[].obs;
  var qualityChecks = <String, bool>{
    'materialQuality': false,
    'quantityAccuracy': false,
    'packaging': false,
  }.obs; // Added for quality checks
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();
  int _orderIdCounter = 0; // ID counter for orders
  RxBool isFullReturn = false.obs;
  final stockService = StockService();
  final OrderService orderService = OrderService();
  final HomeService homeService = HomeService();

  RxList<SupplierData> suppliers = <SupplierData>[].obs;

  List<Order> defaultOrders = [
    // Order(
    //     id: '1',
    //     materialName: "Bricks",
    //     supplierName: 'Hinduja',
    //     quantity: '100',
    //     imagePath: '',
    //     siteName: "Site 1",
    //     returnedQuantity: '',
    //     status: 'pending',
    //     orderCreateDate: DateTime.now().subtract(Duration(days: 10)),
    //     expectedDeliveryDate: DateTime.now(),
    //     instructions: 'Wrap the bricks in plastic, leave at door',
    //     reason: 'Quality is not good'),
    // Order(
    //     id: '2',
    //     materialName: "Bricks",
    //     supplierName: 'Hinduja',
    //     quantity: '100',
    //     imagePath: '',
    //     siteName: "Site 1",
    //     returnedQuantity: '',
    //     status: 'approved',
    //     orderCreateDate: DateTime.now().subtract(Duration(days: 11)),
    //     expectedDeliveryDate: DateTime.now(),
    //     instructions: 'Wrap the bricks in plastic, leave at door',
    //     reason: 'Quality is not good'),
    // Order(
    //     id: '3',
    //     materialName: "Sand",
    //     supplierName: 'Malviya',
    //     quantity: '10',
    //     imagePath: '',
    //     siteName: "Site 2",
    //     returnedQuantity: '5',
    //     status: 'received',
    //     orderCreateDate: DateTime.now(),
    //     expectedDeliveryDate: DateTime.now(),
    //     instructions: 'Wrap the bricks in plastic, leave at door',
    //     reason: 'Quality is not good'),
    // Order(
    //     id: '4',
    //     materialName: "Cement",
    //     supplierName: 'Malviya',
    //     quantity: '10',
    //     imagePath: '',
    //     siteName: "Site 2",
    //     returnedQuantity: '',
    //     status: 'returned',
    //     orderCreateDate: DateTime.now(),
    //     expectedDeliveryDate: DateTime.now().add(Duration(days: 5)),
    //     instructions: 'Wrap the bricks in plastic, leave at door',
    //     reason: 'Quality is not good'),
  ];

  TextEditingController partialReturnQuantityController =
      TextEditingController();

  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();
  SupplierService supplierService = SupplierService();

  @override
  void onInit() {
    siteNotifier.addListener(() {
      if (siteNotifier.value != null) {
        loadOrders();
      }
    });

    // loadOrders();
    loadSites();
    getData();
    update();

    super.onInit();
  }

  List<Order> get filteredOrders {
    final query = filterQuery.value.toLowerCase();

    return orders.where((order) {
      final siteMatch = order.siteName?.toLowerCase().contains(query) ?? false;
      final materialMatch =
          order.materialName?.toLowerCase().contains(query) ?? false;
      final statusMatch =
          order.status == 'pending' || order.status == 'approved';

      final dateMatch = filterDate.value == null ||
          order.orderCreateDate!.isAfter(filterDate.value!);

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

  void updateOrderById(var id, Order updatedOrder) {
    int index = orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      orders.value[index] = updatedOrder;
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

  void partialReturnOrder(int index, int quantity) {
    orders.value[index].returnedQuantity =
        (orders.value[index].returnedQuantity ?? 0) + quantity;
    orders.value[index].status = 'returned';
  }

  void fullReturnOrder(int index) {
    orders.value[index].returnedQuantity = orders.value[index].quantity;
    // orders.value[index].quantity = 'Full';
    orders.value[index].status = 'returned';
  }

  void loadOrders() async {
    List<Order>? storedOrders =
        await orderService.getOrdersBySite(siteId: siteNotifier.value);
    orders.value = storedOrders;
    update();
  }

  void saveOrders() {
    box.write('orders', orders.map((e) => e.toJson()).toList());
  }

  void loadSites() async {
    sites.value = await homeService.getSites();
    update();
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

  void addOrder({String status = 'pending'}) async {
    for (final input in orderInputs) {
      bool hasMaterial = input.selectedMaterial.value.isNotEmpty;
      bool hasQuantity = input.quantityController.text.isNotEmpty;
      if (hasMaterial && hasQuantity) {
        // if(int.parse(input.quantityController.text) * 100 < 10000){
        //   status = "approved";
        // }

        final order = Order(
            materialName: input.selectedMaterial.value,
            supplierId: selectedSupplier.value?.id,
            price: (double.tryParse(input.quantityController.text) ?? 0) * 100,
            quantity: double.tryParse(input.quantityController.text) ?? 0.0,
            siteId: selectedSite?.value.id,
            orderCreateDate: input.orderCreateDate.value,
            expectedDeliveryDate: input.expectedDeliveryDate.value,
            imagePath: '',
            instructions: instructionsController.text,
            qualityCheck: false,
            quantityCheck: false);

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

        orderService.createOrder(order);
      }
    }
    // saveOrders();
    // saveOrderIdCounter();
    clearControllers();
  }

  void returnOrder(Order oldOrder,
      {bool isFullReturn = true, double? partialQuantity}) async {
    Order returnedOrder = oldOrder;
    returnedOrder.returnReason = returnReasonController.text;

    if (isFullReturn) {
      returnedOrder.returnedQuantity = oldOrder.quantity;
      await orderService.returnOrder(returnedOrder);
    } else {
      returnedOrder.returnedQuantity = partialQuantity;
      await orderService.returnOrder(returnedOrder);
    }
    loadOrders();
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

  void updateOrderMaterial(var orderId, Sites? newSite) {
    int index = orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      orders.value[index].siteId = newSite?.id;
      saveOrders(); // Save the updated orders list
      update(); // Notify the UI to refresh
    } else {
      Get.snackbar("Order Not Found", "No order found with ID $orderId");
    }
  }

  void markAsReceived(Order order) async {
    await orderService.markOrderAsReceived(order);
    loadOrders();
  }

  void clearControllers() {
    selectedSupplier.value = null;
    selectedSite = Sites().obs;
    orderInputs.clear();
    qualityChecks.updateAll((key, value) => false);
    instructionsController.clear();
    addOrderInput();
  }

  void getData() async {
    suppliers.value = await supplierService.getAllSuppliers();
    materials.value = await orderService.getAllMaterials();
    update();
  }
}

extension on Order {
  Order merge(Order order) {
    return order;
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
