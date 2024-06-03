import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/onBoarding/widgets/on_boarding_page.dart';

import 'controller/on_boarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final OnBoardingController controller = Get.put(OnBoardingController());
    final PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: 3,
          onPageChanged: (index) {
            controller.currentPage.value = index;
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(
              index: index,
              pageController: pageController,
            );
          },
        ),
      ),
    );
  }
}
