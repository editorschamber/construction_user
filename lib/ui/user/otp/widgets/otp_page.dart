import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:site_construct/ui/user/otp/controller/otp_controller.dart';

import '../../../../constrant/custom_color.dart';
import '../../../../utils/common/common_widgets/custom_button.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "OTP Verify",
            style: TextStyle(color: CustomColor.textColor, fontSize: 33),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Pinput(
            length: 6,
            autofillHints: const [AutofillHints.oneTimeCode],
            showCursor: true,
            onChanged: (value) {
              controller.code = value;
            },
            controller: controller.pinController,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          CustomButton(
            buttonColor: CustomColor.buttonColor,
            buttonText: "Submit",
            onTap: () => controller.verifyOtp(),
          ),
        ],
      ),
    );
  }
}
