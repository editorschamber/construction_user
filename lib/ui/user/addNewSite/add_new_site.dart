import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/core/extension/text_style_extension.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';
import 'package:site_construct/utils/common/common_widgets/custom_text_field.dart';

class AddNewSite extends StatelessWidget {
  const AddNewSite({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Site"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name of site: ").customStyle(),
              SizedBox(
                height: 5,
              ),
              CustomTextField(),
              SizedBox(
                height: 10,
              ),
              Text("Location of site: ").customStyle(),
              SizedBox(
                height: 5,
              ),
              CustomTextField(),
              SizedBox(
                height: 10,
              ),
              Text("Description of site: ").customStyle(),
              SizedBox(
                height: 5,
              ),
              CustomTextField(),
              SizedBox(
                height: 10,
              ),
              Text("Description of site: ").customStyle(),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                height: 200,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Starting Date").customStyle(),
                        CustomTextField(),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 70,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Ending Date").customStyle(),
                        CustomTextField(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 341,
                  height: 121,
                  child: DottedBorder(
                    color: Colors.black,
                    strokeWidth: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.upload), Text("Upload Files")],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(child: CustomButton(buttonColor: CustomColor.containerColor,textColor: Colors.black,buttonText: "Add", onTap: () {})),
            ],
          ),
        )),
      ),
    );
  }
}
