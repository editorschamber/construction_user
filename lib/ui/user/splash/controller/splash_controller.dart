import 'package:get/get.dart';

import '../../../../core/data/database_helper.dart';
import '../../../../core/data/user_model.dart';
import '../../../../routes/route.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), checkUserNumber);
  }

  void checkUserNumber() async {
    String phoneNumber = '';
    UserModel? existingUser =
        await DatabaseHelper.instance.getUserByPhoneNumber(phoneNumber);
    if (existingUser == null) {
      Get.offNamed(navigationMenu);
    } else {
      Get.offNamed(loginScreen);
    }
  }
}
