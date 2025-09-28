import 'dart:convert';
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/apiServices/apiStrings.dart';

class MaterialService {
  final APIServices _apiService = APIServices();

  Future<dynamic> createMaterial({
    required String materialName,
    required int approvedQuantity,
    required String unit,
  }) async {
    final response = await _apiService.postApi(
      APIStrings.createMaterial,
      body: jsonEncode({
        'materialName': materialName,
        'approvedQuantity': approvedQuantity,
        'unit': unit,
      }),
    );
    return response;
  }

  Future<dynamic> getMaterials() async {
    final response = await _apiService.getApi(APIStrings.getAllMaterial);
    return response;
  }
}
