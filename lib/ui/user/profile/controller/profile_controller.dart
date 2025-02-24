import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/apiServices/userService.dart';
import 'package:site_construct/core/models/userModel.dart';
import 'package:site_construct/core/service/storageService.dart';

import '../../homeScreen/home_controller.dart';

class ProfileController extends GetxController {
  final HomeController homeController = Get.put(HomeController());
  var displayName = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController siteController = TextEditingController();

  UserService userService = UserService();
  var base64Image = "".obs; // Store Base64 image

  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imgFile = File(image.path);
      List<int> imageBytes = await imgFile.readAsBytes();
      base64Image.value = base64Encode(imageBytes); // Convert to Base64
      print(base64Image.value.length);
    }
  }

  Future<void> updateProfilePic() async {
    if (base64Image.value.isEmpty) {
      Get.snackbar("Error", "No image selected");
      return;
    }

    try {
      bool success = await userService.updateProfileImage(
          StorageService.userId, base64Image.value);
      if (success) {
        Get.snackbar("Success", "Profile picture updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update profile picture");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile picture");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    UserData? user = await userService.getUserDetails() as UserData?;
    if (user != null) {
      displayName.value = user.displayName ?? "";
      nameController.text = user.displayName ?? "user";
      numberController.text = user.username ?? "phone";
      base64Image.value = "${user.profileImage}";
      print(base64Image.value.length);
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
