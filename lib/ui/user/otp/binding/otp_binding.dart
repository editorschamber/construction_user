import 'package:get/get.dart';
import 'package:site_construct/ui/user/otp/controller/otp_controller.dart';

class OtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}
