import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/extension/text_style_extension.dart';
import 'package:site_construct/ui/user/profile/controller/profile_controller.dart';

import '../../../../constrant/custom_color.dart';
import '../../../../utils/common/common_widgets/custom_button.dart';
import '../../../../utils/common/common_widgets/custom_text_field.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.02),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: width * 0.45,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColor.containerColor,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text("Email: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.emailController),
          SizedBox(
            height: height * 0.01,
          ),
          Text("Phone Number: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.numberController),
          SizedBox(
            height: height * 0.01,
          ),
          Text("Password: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.passwordController),
          SizedBox(
            height: height * 0.01,
          ),
          Text("Site: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.siteController),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: CustomButton(
              textColor: Colors.black,
              buttonColor: CustomColor.containerColor,
              buttonText: "Update",
              onTap: () => controller.updateProfile(),
            ),
          )
        ],
      ),
    );
  }
}
