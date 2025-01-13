import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:site_construct/apiServices/homeService.dart';
import 'package:site_construct/apiServices/stockService.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/core/notifiers/refreshNotifier.dart';

import '../../../core/models/materialQuantity.dart';
import '../../../core/notifiers/selectedSiteNotifier.dart';

class HomeController extends GetxController {
  var displayName = ''.obs;
  Rx<SitesModel> siteModel = SitesModel().obs;
  Rx<Sites>? selectedSite = Sites().obs;
  RxBool isLoading = true.obs;
  StockService stockService = StockService();
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();
  RefreshNotifier refreshNotifier = RefreshNotifier.getInstance();

  @override
  void onInit() {
    refreshNotifier.addListener((){
      fetchStockBySiteName();
    });
    getSitesData();
    super.onInit();
  }

  // Lists
  RxList<MaterialQuantity> filteredReceivedOrders = <MaterialQuantity>[].obs;

  Future<void> fetchStockBySiteName() async {
    filteredReceivedOrders.value =
        await stockService.getAvailableStocks(siteId: "${siteNotifier.value}");
  }

  Future<bool> submitDailyUsage(String materialName, double usedQty) async{
    try {
      var response = await stockService.addDailyUsage(siteId: siteNotifier.value, materialName: materialName, quantityUsed: usedQty);
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
