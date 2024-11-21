import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';

import 'apiServices.dart';

class AuthService {

  final apiService = APIServices();
  // Admin login
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await apiService.postApi(
      APIStrings.login,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log in');
    }
  }

  // Verify JWT token
  Future<Map<String, dynamic>> verifyToken(String token) async {
    final response = await apiService.postApi(
      APIStrings.verifyUser,
      body: json.encode({'token': token}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify token');
    }
  }
}