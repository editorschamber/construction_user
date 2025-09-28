import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:site_construct/apiServices/apiStrings.dart';

import 'apiServices.dart';

class SupervisorService {
  APIServices apiServices = APIServices();
  // Get all supervisors
  Future<List<dynamic>> getSupervisors() async {
    final response = await apiServices.getApi(APIStrings.supervisors);

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load supervisors');
    }
  }

  // Add a new supervisor
  Future<Map<String, dynamic>> addSupervisor(
      Map<String, dynamic> supervisorData) async {
    final response = await apiServices.postApi(
      APIStrings.supervisors,
      body: json.encode(supervisorData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add supervisor');
    }
  }
}
