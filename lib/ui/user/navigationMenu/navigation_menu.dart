import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/addNewSite/add_new_site.dart';
import 'package:site_construct/ui/user/employeeDetails/employee_details_screen.dart';
import 'package:site_construct/ui/user/homeScreen/home_screen.dart';
import 'package:site_construct/ui/user/material/material_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.add), label: "Employee"),
            NavigationDestination(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [HomeScreen(), AddNewSite(), MaterialScreen()];
}
