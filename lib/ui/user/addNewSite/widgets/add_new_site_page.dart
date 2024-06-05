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
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name of site: ").customStyle(),
          SizedBox(
            height: 5,
          ),
          CustomTextField(controller: controller.siteNameController),
          SizedBox(
            height: 10,
          ),
          Text("Location of site: ").customStyle(),
          SizedBox(
            height: 5,
          ),
          CustomTextField(controller: controller.locationController),
          SizedBox(
            height: 10,
          ),
          Text("Description of site: ").customStyle(),
          SizedBox(
            height: 5,
          ),
          CustomTextField(
            controller: controller.descriptionController,
            height: 200,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Starting Date").customStyle(),
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
              Container(
                width: 150,
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Ending Date").customStyle(),
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
          SizedBox(
            height: 15,
          ),
          Center(
            child: GestureDetector(
              onTap: () => controller.pickFile(),
              child: Container(
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
                            Icon(Icons.upload),
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
          SizedBox(
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
