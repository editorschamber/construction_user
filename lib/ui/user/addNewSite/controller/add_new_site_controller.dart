import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class AddNewSiteController extends GetxController {
  TextEditingController siteNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  var selectedFilePath = ''.obs;

  void addFun() {
    String siteName = siteNameController.text;
    String location = locationController.text;
    String description = descriptionController.text;
    String startDate = startDateController.text;
    String endDate = endDateController.text;
    String filePath = selectedFilePath.value;

    print("Site name: $siteName");
    print("Location: $location");
    print("Description: $description");
    print("Start Date: $startDate");
    print("End Date: $endDate");
    print("File Path: $filePath");

    Get.snackbar(
      "Success",
      "Site added successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        selectedFilePath.value = result.files.single.path ?? '';
      } else {
        selectedFilePath.value = ''; // Reset the file path if file picking is canceled
      }
    } catch (e) {
      print("Error picking file: $e");
      Get.snackbar(
        "Error",
        "Failed to pick file",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    siteNameController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }
}
