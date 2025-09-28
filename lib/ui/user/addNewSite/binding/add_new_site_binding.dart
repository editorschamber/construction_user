import 'package:get/get.dart';
import 'package:site_construct/ui/user/addNewSite/controller/add_new_site_controller.dart';

class AddNewSiteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewSiteController>(() => AddNewSiteController());
  }
}
