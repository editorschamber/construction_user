import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:site_construct/utils/userModel.dart';

class ProfileController extends GetxController {
  var displayName = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController siteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    UserModel? user = UserModel.readFromStorage();
    if (user != null) {
      displayName.value = user.username;
      nameController.text = user.username;
      numberController.text = user.phoneNumber;
    }
  }

  void updateProfile() {
    UserModel user = UserModel(
      username: nameController.text,
      phoneNumber: numberController.text,
    );
    user.saveToStorage();
    displayName.value = user.username;
    Get.snackbar("Profile Updated", '');
  }
}