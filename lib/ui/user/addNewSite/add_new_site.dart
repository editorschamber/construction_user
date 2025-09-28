import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:site_construct/ui/user/addNewSite/widgets/add_new_site_page.dart';

import 'controller/add_new_site_controller.dart';

class AddNewSite extends GetView<AddNewSiteController> {
  const AddNewSite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.near_me),
        title: const Text("Add New Site"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: AddNewSitePage(),
        ),
      ),
    );
  }
}
