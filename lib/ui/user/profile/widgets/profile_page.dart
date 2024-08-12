import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/extension/text_style_extension.dart';
import 'package:site_construct/ui/user/profile/controller/profile_controller.dart';

import '../../../../constrant/custom_color.dart';
import '../../../../utils/common/common_widgets/custom_text_field.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColor.containerColor,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Obx(() {
                      return Text(
                        controller.displayName.value.isNotEmpty
                            ? controller.displayName.value
                            : "Name",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          const Text("Name: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.nameController),
          SizedBox(
            height: height * 0.01,
          ),
          const Text("Phone Number: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.numberController),
          SizedBox(
            height: height * 0.01,
          ),
          const Text("Password: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.passwordController),
          SizedBox(
            height: height * 0.01,
          ),
          const Text("Site: ").customStyle(),
          SizedBox(
            height: height * 0.006,
          ),
          CustomTextField(controller: controller.siteController),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, // Button color
                backgroundColor: Colors.deepPurple.shade100, // Text color
              ),
              onPressed: () => controller.updateProfile(),
              child: const Text("Update"),
            ),
          )
        ],
      ),
    );
  }
}