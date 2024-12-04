import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:site_construct/apiServices/apiServices.dart';
import 'package:site_construct/ui/user/homeScreen/home_screen.dart';

import '../../../../apiServices/apiStrings.dart';
import '../../../../core/service/storageService.dart';
import '../../../../routes/route.dart';
import '../../navigationMenu/navigation_menu.dart';
import '../login_screen.dart';

class LoginController extends GetxController {
  TextEditingController countryCode = TextEditingController(text: '+91');
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GetStorage storage = GetStorage();
  APIServices apiServices = APIServices();

  void verifyPhoneNumber() async {
    String phoneNumber = countryCode.text + numberController.text.trim();
    String password = passwordController.text.trim();

    if (phoneNumber.length < 10) {
      Get.defaultDialog(
        title: 'Invalid Phone Number',
        content: const Text('Please enter a valid phone number.'),
      );
      return;
    }

    try {
      var response = await apiServices.postApi(
        APIStrings.login,
        body: jsonEncode(
            {'username': numberController.text.trim(), 'password': password}),
      );

      if (response != null) {
        // final data = jsonDecode(response);
        final accessToken = response['accessToken'];
        final refreshToken = response['refreshToken'];
        final userId = response['userId'];
        StorageService.saveUserData(accessToken, refreshToken, userId);
        Get.offAll(NavigationMenu());
      } else {
        Get.snackbar(
            'Error', 'Failed to verify phone number. Please try again.');
      }
    } catch (e) {
      // Catch any other exceptions
      log(e.toString());
      Get.snackbar('Error', 'Failed to verify phone number. Please try again.');
    }
  }
}
