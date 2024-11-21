import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/route.dart';

class SplashController extends GetxController {
  final GetStorage storage = GetStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init(); // Initialize GetStorage
    Future.delayed(const Duration(seconds: 5), checkUserNumber);
  }

  void checkUserNumber() {
    String? phoneNumber = storage.read('phoneNumber');
    if (_firebaseAuth.currentUser != null) {
      Get.offNamed(navigationMenu);
    } else {
      Get.offNamed(loginScreen);
    }
  }
}
