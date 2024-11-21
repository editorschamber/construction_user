import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/ui/user/login/controller/login_controller.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';
import 'package:site_construct/utils/common/common_widgets/custom_enter_number.dart';

import '../../../../utils/common/common_widgets/common_textfield.dart';

class LoginPage extends GetView<LoginController> {
   LoginPage({super.key});


  final TextEditingController phoneController = TextEditingController();
  final authController = Get.find<LoginController>();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Login",
          style: TextStyle(color: CustomColor.textColor, fontSize: 33),
        ),

        SizedBox(
          height: height * 0.04,
        ),
        const Text(
          "Enter Your Mobile Number",
          style: TextStyle(color: CustomColor.lightGrey, fontSize: 14),
          textAlign: TextAlign.start,
        ),

        CustomEnterNumber(
          countryCode: controller.countryCode,
          numberController: authController.numberController,
        ),

        const Text(
          "Enter Your Passowrd",
          style: TextStyle(color: CustomColor.lightGrey, fontSize: 14),
          textAlign: TextAlign.start,
        ),
        CustomTextfield(
            password: authController.passwordController,
        ),
        SizedBox(
          height: height * 0.07,
        ),
        CustomButton(
          buttonColor: CustomColor.buttonColor,
          buttonText: "verify",
          onTap: () {
            authController.verifyPhoneNumber();
          },
        )
      ],
    );
  }
}
