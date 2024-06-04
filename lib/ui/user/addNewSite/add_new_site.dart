import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:site_construct/constrant/custom_color.dart';
import 'package:site_construct/core/extension/text_style_extension.dart';
import 'package:site_construct/ui/user/addNewSite/widgets/add_new_site_page.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';
import 'package:site_construct/utils/common/common_widgets/custom_text_field.dart';

import 'controller/add_new_site_controller.dart';

class AddNewSite extends GetView<AddNewSiteController> {
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
          child:AddNewSitePage(),
        ),
      ),
    );
  }
}
