import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/details/widgets/details_page.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

import '../../../routes/route.dart';
import '../../../core/data/site.dart';

class DetailsScreen extends StatefulWidget {
  final Site site;

  const DetailsScreen({super.key, required this.site});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                DetailsPage(site: widget.site),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
