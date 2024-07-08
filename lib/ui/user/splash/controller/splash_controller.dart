import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/route.dart';

class SplashController extends GetxController {
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    GetStorage.init(); // Initialize GetStorage
    Future.delayed(const Duration(seconds: 5), checkUserNumber);
  }

  void checkUserNumber() {
    String? phoneNumber = storage.read('phoneNumber');
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      Get.offNamed(navigationMenu);
    } else {
      Get.offNamed(loginScreen);
    }
  }
}
