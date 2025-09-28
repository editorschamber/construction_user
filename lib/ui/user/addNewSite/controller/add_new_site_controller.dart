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
        selectedFilePath.value =
            ''; // Reset the file path if file picking is canceled
      }
    } catch (e) {
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
