import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddNewSiteController extends GetxController{
  TextEditingController siteNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addFun(){
    String siteName = siteNameController.text;
    String location = locationController.text;
    String description = descriptionController.text;

    print("site name: $siteName");
    print("site name: $location");
    print("site name: $description");

    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}