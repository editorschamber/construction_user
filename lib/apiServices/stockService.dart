import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/apiServices/apiStrings.dart';

class StockService {

  APIServices apiServices = APIServices();
  // Get all available stocks
  Future<List<dynamic>> getAvailableStocks() async {
    final response = await apiServices.getApi(
      APIStrings.availableStocks
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load available stocks');
    }
  }

  // Add a new stock
  Future<Map<String, dynamic>> addStock(String name, int quantity, double price) async {
    final response = await apiServices.postApi(
        APIStrings.availableStocks,
      body: json.encode({
        'name': name,
        'quantity': quantity,
        'price': price,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add stock');
    }
  }
}