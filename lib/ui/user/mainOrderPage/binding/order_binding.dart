import 'package:get/get.dart';
import '../controller/main_order_controller.dart';

class MainOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainOrderController>(() => MainOrderController());
  }
}
