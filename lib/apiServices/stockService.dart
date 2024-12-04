import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/apiServices/apiStrings.dart';
import 'package:site_construct/apiServices/userService.dart';
import 'package:site_construct/core/models/materialQuantity.dart';
import 'package:site_construct/core/models/userModel.dart';

import '../ui/user/homeScreen/home_controller.dart';

class StockService {

  APIServices apiServices = APIServices();
  // Get all available stocks
  Future<List<MaterialQuantity>> getAvailableStocks({required String siteId}) async {
    final response = await apiServices.getApi(
      "${APIStrings.availableStocks}?siteId=${siteId}"
    );

    if (response != null) {
      return materialQuantityFromJson(jsonEncode(response['data']));
    } else {
      throw Exception('Failed to load available stocks');
    }
  }

  // Add a new stock
  // Future<Map<String, dynamic>> addStock(String name, int quantity, double price) async {
  //   final response = await apiServices.postApi(
  //       APIStrings.availableStocks,
  //     body: json.encode({
  //       'name': name,
  //       'quantity': quantity,
  //       'price': price,
  //     }),
  //   );
  //
  //   if (response.statusCode == 201) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to add stock');
  //   }
  // }
}