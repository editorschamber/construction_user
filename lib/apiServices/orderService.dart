import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';
import 'package:site_construct/core/data/orderModel.dart';

import '../core/models/matarialData.dart';
import 'apiServices.dart';

class OrderService {
  final apiService = APIServices();

  // Get all approved orders
  Future<List<dynamic>> getApprovedOrders() async {
    final response = await apiService.getApi(APIStrings.approvedOrders);

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load approved orders');
    }
  }

  Future<List<Order>> getOrdersBySite({required int? siteId}) async {
    final response =
        await apiService.getApi("${APIStrings.getOrdersBySite}?siteId=$siteId");

    if (response != null) {
      return orderFromJson(jsonEncode(response['data']));
    } else {
      throw Exception('Failed to load approved orders');
    }
  }

  Future<List<Order>> getOrdersByUser({required String? userId}) async {
    final response =
        await apiService.getApi("${APIStrings.getOrdersByUser}?userId=$userId");

    if (response != null) {
      return orderFromJson(jsonEncode(response['data']));
    } else {
      throw Exception('Failed to load approved orders');
    }
  }

  Future<List<Materials>> getAllMaterials() async {
    final response = await apiService.getApi(APIStrings.getAllMaterial);

    if (response != null) {
      return materialFromJson(jsonEncode(response['data']));
    } else {
      throw Exception('Failed to load approved orders');
    }
  }

  // Create a new order
  Future createOrder(Order orderData) async {
    final response = await apiService.postApi(
      APIStrings.createOrder,
      body: jsonEncode(orderData.toJson()),
    );

    print("response create order $response");
    if (response != null) {
      return true;
    } else {
      throw Exception('Failed to create order');
    }
  }

  // Create a new order
  Future updateOrder(Order orderData) async {
    print(orderData.toJson());
    final response = await apiService.putApi(
      APIStrings.updateOrder,
      body: jsonEncode(orderData.toJson()),
    );

    print("response create order $response");
    if (response != null) {
      return true;
    } else {
      throw Exception('Failed to create order');
    }
  }

  // Mark an order as received
  Future<Map<String, dynamic>> markOrderAsReceived(Order order,
      {String? remark}) async {
    final response = await apiService.putApi('orders/receiveOrders', body: {
      "id": order.id,
      "qualityCheck": order.qualityCheck,
      "quantityCheck": order.quantityCheck,
      "remarks": remark,
    });

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to update order status');
    }
  }

  Future<Map<String, dynamic>> returnOrder(Order order) async {
    final response = await apiService.postApi('orders/returnOrder',
        body: jsonEncode({
          "orderId": order.id,
          "returnedQuantity": order.returnedQuantity,
          "returnReason": order.returnReason,
          "returnImage": order.returnImage ?? ""
        }));

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to update order status');
    }
  }

  Future<bool> deleteOrder(Order order) async {
    final response = await apiService
        .deleteApi('orders/delete', body: {"id": order.id ?? 0});

    print(response);
    return response != null;
  }
}
