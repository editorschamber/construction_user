import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:site_construct/core/service/storageService.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/profile/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Minimalist background
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Obx(() {
                              return Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  image: controller.base64Image.value.isNotEmpty
                                      ? DecorationImage(
                                          image: MemoryImage(
                                            base64Decode(
                                                controller.base64Image.value),
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : const DecorationImage(
                                          image: AssetImage(
                                              "assets/default_profile.png"), // Ensure correct path
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              );
                            }),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  await controller.pickImage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: const Icon(Icons.camera_alt,
                                      color: Colors.black, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // User Name
                      Obx(() {
                        return Text(
                          controller.displayName.value.isNotEmpty
                              ? controller.displayName.value
                              : "User Name",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        );
                      }),

                      const SizedBox(height: 20),

                      // Profile Fields
                      buildProfileField("Name", controller.nameController),
                      buildProfileField(
                          "Phone Number", controller.numberController),

                      const SizedBox(height: 25),

                      // Assigned Sites
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Assigned Sites",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        if (controller.homeController.siteModel.value.data ==
                                null ||
                            controller
                                .homeController.siteModel.value.data!.isEmpty) {
                          return const Text("No sites assigned",
                              style: TextStyle(color: Colors.grey));
                        }

                        return Column(
                            children: controller
                                    .homeController.siteModel.value.data
                                    ?.map<Widget>((site) {
                                  return Card(
                                    elevation: 0,
                                    color: Colors.grey.shade50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: ListTile(
                                      leading: const Icon(Icons.location_on,
                                          color: Colors.black),
                                      title: Text("${site.siteName}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      subtitle: Text("${site.location}",
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  );
                                }).toList() ??
                                []);
                      }),

                      const SizedBox(height: 25),

                      // Save Profile Picture Button
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.primaries.first,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            elevation: 2,
                          ),
                          onPressed: () => controller.updateProfilePic(),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Logout Button
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Get.defaultDialog(
                                title: "Logout",
                                middleText: "are you sure?",
                                confirm: ElevatedButton(
                                    onPressed: () {
                                      StorageService.clearTokens();
                                      Get.toNamed(loginScreen);
                                    },
                                    child: Text("Logout")),
                                cancel: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancel")),
                                titlePadding: EdgeInsets.only(top: 24),
                                contentPadding: EdgeInsets.only(bottom: 12),
                                titleStyle: TextStyle(color: Colors.redAccent),
                                buttonColor: Colors.redAccent,
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  StorageService.clearTokens();
                                  Get.toNamed(loginScreen);
                                },
                                onCancel: () {
                                  Get.back();
                                });
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds Profile Field UI
  Widget buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            ),
          ),
        ],
      ),
    );
  }
}
