import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {

  // Get all users
  Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse('admin/users'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Create a new user
  Future<Map<String, dynamic>> createUser(String username, String password, String role) async {
    final response = await http.post(
      Uri.parse('admin/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create user');
    }
  }
}