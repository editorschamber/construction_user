import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';
import 'package:site_construct/core/models/userModel.dart';

import '../core/service/storageService.dart';
import 'apiServices.dart';

class UserService {
  APIServices apiServices = APIServices();


  // Get all users
  Future<List<dynamic>> getUsers() async {
    final response = await apiServices.getApi(
      APIStrings.users
    );

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<UserData> getUserDetails() async {
    final response = await apiServices.getApi("${APIStrings.getUserDetails}?id=${StorageService.userId}");

    if (response != null) {
      return userDataFromJson(jsonEncode(response["data"]));
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Create a new user
  Future<Map<String, dynamic>> createUser(String username, String password, String role) async {
    final response = await apiServices.postApi(
      APIStrings.users,
      body: json.encode({
        'username': username,
        'password': password,
        'role': role,
      }),
    );

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to create user');
    }
  }
}