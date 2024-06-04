import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController siteController = TextEditingController();

  void updateProfile(){
    String email = emailController.text;
    String number = numberController.text;
    String password = passwordController.text;
    String site = siteController.text;

    print("Email: $email");
    print("Phone Number: $number");
    print("Password: $password");
    print("Site: $site");

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }



}