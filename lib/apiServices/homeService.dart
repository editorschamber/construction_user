import 'dart:convert';

import 'package:site_construct/core/service/storageService.dart';

import 'apiServices.dart';
import 'apiStrings.dart';

class HomeService {
  final apiService = APIServices();

  // Get all approved orders
  Future getSites() async {
    final response = await apiService.getApi(
        "${APIStrings.getSitesByUserId}?userId=${StorageService.userId}");

    if (response != null) {
      print("getSites data is ${response}");

      return response;
    } else {
      throw Exception('Failed to load getSites data');
    }
  }
}
