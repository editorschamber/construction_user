import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';

import 'apiServices.dart';

class ConstructionSiteService {
  final apiService = APIServices();

  // Get all construction sites
  Future<List<dynamic>> getConstructionSites() async {
    final response = await apiService.getApi(
      APIStrings.constructionSites,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load construction sites');
    }
  }

  // Add a new construction site
  Future<Map<String, dynamic>> addConstructionSite(Map<String, dynamic> siteData) async {
    final response = await apiService.postApi(
      APIStrings.constructionSites,
      body: json.encode(siteData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add construction site');
    }
  }
}