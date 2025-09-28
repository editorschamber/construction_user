import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/apiServices/attendanceService.dart';
import 'package:site_construct/apiServices/homeService.dart';
import 'package:site_construct/apiServices/stockService.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/core/models/userModel.dart';
import 'package:site_construct/core/notifiers/refreshNotifier.dart';

import '../../../apiServices/userService.dart';
import '../../../core/models/materialQuantity.dart';
import '../../../core/notifiers/selectedSiteNotifier.dart';
import 'package:image/image.dart' as img;

class HomeController extends GetxController {
  var displayName = ''.obs;
  Rx<SitesModel> siteModel = SitesModel().obs;
  Rx<Sites>? selectedSite = Sites().obs;
  RxBool isLoading = true.obs;
  StockService stockService = StockService();
  AttendanceService attendanceService = AttendanceService();
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();
  RefreshNotifier refreshNotifier = RefreshNotifier.getInstance();
  UserService userService = UserService();
  var base64Image = "".obs; // Store Base64 image

  final ImagePicker _picker = ImagePicker();
  RxBool isAttendanceMarked = false.obs;

  Future<void> pickImage() async {
    final status = isAttendanceMarked.value ? "OUT" : "IN";
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    print(image);
    if (image != null) {
      File imgFile = File(image.path);
      var imageBytes = await imgFile.readAsBytes();
      final decodedImg = img.decodeImage(imageBytes);
      final resized = img.copyResize(decodedImg!, width: 600); // reduce size
      final jpg = img.encodeJpg(resized, quality: 70);
      base64Image.value = base64Encode(jpg); // Convert to Base64
      // print(base64Image.value.length);
      var response = await attendanceService.markAttendance(
          base64Image.value, siteNotifier.value, status);
      if (response != null) {
        Get.snackbar("Success", response['message']);
        getAttendanceData();
      } else {
        Get.snackbar("Failure", "Please try again!");
      }
    } else {
      Get.snackbar("Failure", "Image not captured!");
    }
  }

  @override
  void onInit() {
    refreshNotifier.addListener(() {
      fetchStockBySiteName();
    });
    getSitesData();
    getAttendanceData();
    super.onInit();
  }

  // Lists
  RxList<MaterialQuantity> filteredReceivedOrders = <MaterialQuantity>[].obs;

  Future<void> fetchStockBySiteName() async {
    filteredReceivedOrders.value =
        await stockService.getAvailableStocks(siteId: "${siteNotifier.value}");
  }

  Future<void> getAttendanceData() async {
    try {
      UserData? user = await userService.getUserDetails() as UserData?;

      var response =
          await attendanceService.getSupervisorAttendance(user?.userId);
      if (response.attendance != null && response.attendance!.isNotEmpty) {
        isAttendanceMarked.value = response.attendance!.any((attendance) =>
            attendance.status == "IN" &&
            DateTime.now()
                    .difference(DateTime.parse(attendance.createdAt ?? ""))
                    .inDays ==
                0);
      } else {
        isAttendanceMarked.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while fetching attendance data");
    }
  }

  Future<bool> submitDailyUsage(String materialName, double usedQty) async {
    try {
      var response = await stockService.addDailyUsage(
          siteId: siteNotifier.value,
          materialName: materialName,
          quantityUsed: usedQty);
      print(response);
      return jsonEncode(response).isNotEmpty;
    } on Exception catch (e) {
      return false;
    }
  }

  Future getSitesData() async {
    HomeService service = HomeService();

    var data = await service.getSites();
    SitesModel siteData = SitesModel.fromJson(data);

    siteModel.value = siteData;

    if (siteModel.value.data?.isNotEmpty == true) {
      selectedSite?.value = siteModel.value.data?[0] ?? Sites();
      siteNotifier.updateSiteId(siteModel.value.data?[0].id);
      fetchStockBySiteName();
    }
    isLoading.value = false;
  }

  void onSiteChanged(Sites? site) {
    selectedSite?.value = site ?? Sites();
    siteNotifier.updateSiteId(site?.id);
    fetchStockBySiteName();
  }
}
