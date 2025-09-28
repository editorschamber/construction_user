import 'dart:convert';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/core/models/supplierData.dart';

class SupplierService {
  APIServices apiServices = APIServices();

  SupplierService();

  // Fetch a single supplier by ID
  Future<Map<String, dynamic>?> getSupplierById(int id) async {
    try {
      final response = await apiServices.getApi('supplier/$id');
      if (response != null) {
        return json.decode(response['data']);
      } else if (response.statusCode == 404) {
        print('Supplier not found');
        return null;
      } else {
        throw Exception('Failed to load supplier');
      }
    } catch (e) {
      throw Exception('Error fetching supplier: $e');
      return null;
    }
  }

  // Fetch all suppliers
  Future<List<SupplierData>> getAllSuppliers() async {
    try {
      final response = await apiServices.getApi('supplier/create');
      if (response != null) {
        print(response['data']);
        return supplierDataFromJson(jsonEncode(response['data']));
      } else {
        throw Exception('Failed to load suppliers');
      }
    } catch (e) {
      throw Exception('Error fetching suppliers: $e');
    }
  }

  // Create a new supplier
  Future<bool> createSupplier(Map<String, dynamic> supplierData) async {
    try {
      final response = await apiServices.postApi(
        'supplier/create',
        body: json.encode(supplierData),
      );
      if (response != null) {
        return true;
      } else {
        print('Failed to create supplier: ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Error creating supplier: $e');
    }
  }
}
