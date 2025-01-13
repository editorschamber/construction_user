import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/ui/user/icon/icon_screen.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import '../availableStock/available_stock.dart';
import '../sitePlans/site_plans.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final MainOrderController orderController = Get.put(MainOrderController());
  final PageController _pageController = PageController(); // Controller for horizontal scroll

  @override
  void initState() {
    super.initState();
    // homeController..getSitesData(); // Fetch sites initially
  }

  /// Function to refresh data when user pulls down
  Future<void> _refreshData() async {
    await orderController.loadOrders(); // Fetch updated order data
    await homeController.fetchStockBySiteName();
    homeController.update(); // Trigger UI update after data refresh
    orderController.update(); // Ensure order data is refreshed too
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (homeController.isLoading.value || homeController.siteModel.value.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final List<Sites> sitesList = homeController.siteModel.value.data!;

          return RefreshIndicator(
            onRefresh: _refreshData, // Trigger pull-to-refresh function
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed('/profileScreen');
                        },
                        icon: const Icon(Icons.account_circle_rounded),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          Get.to(() => IconScreen());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // PageView for horizontal site scrolling
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: sitesList.length,
                      onPageChanged: (index) {
                        // Update the selected site when the page changes
                        homeController.onSiteChanged(sitesList[index]);
                        _refreshData(); // Refresh data based on new site
                      },
                      itemBuilder: (context, index) {
                        final site = sitesList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                site.siteName ?? "No Site Name",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      SitePlans(site: site),
                                      const SizedBox(height: 20),
                                      AvailableStock(
                                        site: site,
                                        homeController: homeController,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}