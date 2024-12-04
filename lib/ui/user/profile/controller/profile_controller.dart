import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:site_construct/apiServices/userService.dart';
import 'package:site_construct/core/models/userModel.dart';

class ProfileController extends GetxController {
  var displayName = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController siteController = TextEditingController();

  UserService userService = UserService();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async{
    UserData? user = await userService.getUserDetails() as UserData?;
    if (user != null) {
      displayName.value = user.username ?? "";
      nameController.text = user.role ?? "user";
      // numberController.text = user.phoneNumber;
    }
  }

  void updateProfile() {
    // UserData user = UserData(
    //   username: nameController.text,
    //   phoneNumber: numberController.text,
    // );
    // user.saveToStorage();
    // displayName.value = user.username;
    // Get.snackbar("Profile Updated", '');
  }
}