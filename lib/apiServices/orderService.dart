import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';

import 'apiServices.dart';

class OrderService {

  final apiService = APIServices();
  // Get all approved orders
  Future<List<dynamic>> getApprovedOrders() async {
    final response = await apiService.getApi(
      APIStrings.approvedOrders
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load approved orders');
    }
  }

  // Create a new order
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    final response = await apiService.postApi(
      APIStrings.createOrder,
      body: json.encode(orderData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create order');
    }
  }

  // Mark an order as received
  Future<Map<String, dynamic>> markOrderAsReceived(int orderId) async {
    // final response = await apiService.patch(
    //   Uri.parse('receive/$orderId'),
    // );
    //
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else {
    //   throw Exception('Failed to update order status');
    // }
    return {};
  }
}