import 'dart:math';

import 'package:get/get.dart';
import 'package:site_construct/apiServices/homeService.dart';
import 'package:site_construct/apiServices/stockService.dart';
import 'package:site_construct/core/data/sitesModel.dart';

import '../../../core/models/materialQuantity.dart';
import '../../../core/notifiers/selectedSiteNotifier.dart';

class HomeController extends GetxController {
  var displayName = ''.obs;
  Rx<SitesModel> siteModel = SitesModel().obs;
  Rx<Sites>? selectedSite = Sites().obs;
  RxBool isLoading = true.obs;
  StockService stockService = StockService();
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();

  @override
  void onInit() {
    getSitesData();
    super.onInit();
  }

  // Lists
  RxList<MaterialQuantity> filteredReceivedOrders = <MaterialQuantity>[].obs;

  Future<void> fetchStockBySiteName() async {
    filteredReceivedOrders.value =
        await stockService.getAvailableStocks(siteId: "${siteNotifier.value}");
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
