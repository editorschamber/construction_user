import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/extension/text_style_extension.dart';
import 'package:site_construct/ui/user/addNewSite/controller/add_new_site_controller.dart';

import '../../../../constrant/custom_color.dart';
import '../../../../utils/common/common_widgets/custom_button.dart';
import '../../../../utils/common/common_widgets/custom_text_field.dart';

class AddNewSitePage extends GetView<AddNewSiteController> {
  const AddNewSitePage({super.key});

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name of site: ").customStyle(),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(controller: controller.siteNameController),
          const SizedBox(
            height: 10,
          ),
          const Text("Location of site: ").customStyle(),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(controller: controller.locationController),
          const SizedBox(
            height: 10,
          ),
          const Text("Description of site: ").customStyle(),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            controller: controller.descriptionController,
            height: 200,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Starting Date").customStyle(),
                    GestureDetector(
                      onTap: () =>
                          _selectDate(context, controller.startDateController),
                      child: AbsorbPointer(
                        child: CustomTextField(
                            controller: controller.startDateController),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Ending Date").customStyle(),
                    GestureDetector(
                      onTap: () =>
                          _selectDate(context, controller.endDateController),
                      child: AbsorbPointer(
                        child: CustomTextField(
                            controller: controller.endDateController),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: GestureDetector(
              onTap: () => controller.pickFile(),
              child: SizedBox(
                width: 341,
                height: 121,
                child: DottedBorder(
                  color: Colors.black,
                  strokeWidth: 1,
                  child: Center(
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.selectedFilePath.isEmpty)
                            const Icon(Icons.upload),
                          Text(
                            controller.selectedFilePath.isEmpty
                                ? "Upload Files"
                                : controller.selectedFilePath.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: CustomButton(
              buttonColor: CustomColor.containerColor,
              textColor: Colors.black,
              buttonText: "Add",
              onTap: () => controller.addFun(),
            ),
          ),
        ],
      ),
    );
  }
}
