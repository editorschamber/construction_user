import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var name = ''.obs;
  var number = ''.obs;
  var password = ''.obs;
  var site = ''.obs;

  // Separate observable for the displayed name
  var displayName = ''.obs;

  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController passwordController;
  late TextEditingController siteController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    nameController = TextEditingController();
    numberController = TextEditingController();
    passwordController = TextEditingController();
    siteController = TextEditingController();

    // Bind controllers to observables
    emailController.addListener(() {
      email.value = emailController.text;
    });
    nameController.addListener(() {
      name.value = nameController.text;
    });
    numberController.addListener(() {
      number.value = numberController.text;
    });
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
    siteController.addListener(() {
      site.value = siteController.text;
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    siteController.dispose();
    super.onClose();
  }

  void updateProfile() {
    // Update the displayName observable
    displayName.value = name.value;

    print("Email: ${email.value}");
    print("Phone Number: ${number.value}");
    print("Password: ${password.value}");
    print("Site: ${site.value}");

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
