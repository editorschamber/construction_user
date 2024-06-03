import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/ui/user/onBoarding/controller/on_boarding_controller.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

class OnBoardingPage extends StatelessWidget {
  final int index;
  final PageController pageController;

  const OnBoardingPage({required this.index, required this.pageController, super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final OnBoardingController controller = Get.find();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
        width: media.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 303,
              width: 287,
              decoration: BoxDecoration(
                color: CustomColor.containerColor,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Lorem ipsum dolor sit amet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 25),
            if (index < 2) ...[
              SizedBox(
                height: 50,
                width: media.width,
                child: CustomButton(
                  buttonColor: CustomColor.containerColor,
                  buttonText: "Next",
                  onTap: () => controller.nextPage(pageController),
                ),
              ),
              TextButton(
                onPressed: () => controller.skip(pageController),
                child: Text('Skip'),
              ),
            ] else ...[
              SizedBox(
                height: 50,
                width: media.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white, // Text color
                    side: BorderSide(color: Colors.grey), // Border color
                  ),
                  onPressed: () {
                    // Sign Up functionality
                  },
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
