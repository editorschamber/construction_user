import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/core/data/sitesModel.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/icon/icon_screen.dart';
import 'package:site_construct/ui/user/mainOrderPage/controller/main_order_controller.dart';
import 'package:site_construct/ui/user/orderPage/controller/order_controller.dart';
import 'package:site_construct/ui/user/profile/profile_screen.dart';
import '../availableStock/available_stock.dart';
import '../profile/controller/profile_controller.dart';
import '../sitePlans/site_plans.dart';
import '../siteTeam/site_team.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final MainOrderController orderController = Get.find<MainOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody());
  }

  Widget buildBody() {
    return Obx(() {
      if (homeController.isLoading.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                        Get.toNamed(profileScreen);
                      }, icon: Icon(Icons.account_circle_rounded)),
                      Center(
                        child: Obx(() {
                          return DropdownButton<Sites>(
                            value: homeController.selectedSite?.value,
                            onChanged: homeController.onSiteChanged,
                            items: homeController.siteModel.value.data
                                ?.map((Sites site) {
                              return DropdownMenuItem<Sites>(
                                value: site,
                                child: Text(site.siteName ?? ""),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        onPressed: () {
                          Get.to(IconScreen());
                        },
                      ),
                    ],
                  ),
                  // Dropdown to select site
                  const SizedBox(height: 20),
                  Obx(() {
                    return SitePlans(site: homeController.selectedSite?.value);
                  }),
                  const SizedBox(height: 20),
                  // Available Stock widget updated with selected site
                  AvailableStock(
                      site: homeController.selectedSite?.value,
                      homeController: homeController),
                  const SizedBox(height: 20),

                  // Site Team widget updated with selected site
                  // SiteTeam(site: selectedSite),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
