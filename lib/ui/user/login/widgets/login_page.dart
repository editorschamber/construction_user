import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/ui/user/login/controller/login_controller.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';
import 'package:site_construct/utils/common/common_widgets/custom_enter_number.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

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
          height: height * 0.01,
        ),
        const Text(
          "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.",
          style: TextStyle(color: CustomColor.lightGrey, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: height * 0.07,
        ),
        CustomEnterNumber(
          countryCode: controller.countryCode,
          numberController: controller.numberController,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        CustomButton(
          buttonColor: CustomColor.buttonColor,
          buttonText: "Send OTP",
          onTap: () {
            Get.find<LoginController>().verifyPhoneNumber();
          },
        )
      ],
    );
  }
}
