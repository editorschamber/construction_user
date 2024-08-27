import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/ui/user/dailyUse/dailyUsePage.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

import '../../../../routes/route.dart';
import '../../../../core/data/site.dart';

class DetailsPage extends StatelessWidget {
  final Site site;

  const DetailsPage({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Hero(
              tag: 1,
              child: Image.asset(
                site.imageUrl,
                height: height * 0.3,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                site.siteName,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  const Icon(Icons.maps_home_work),
                  const SizedBox(height: 5),
                  Text(site.location),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Text(site.siteDetails).greyStyled(),
          CustomButton(
            width: width,
            buttonColor: Colors.purple,
            buttonText: "Labour Details",
            onTap: () => Get.toNamed(labourScreen),
          ),
          // const SizedBox(height: 15),
          // CustomButton(
          //   width: width,
          //   buttonColor: Colors.purple,
          //   buttonText: "Material Details",
          //   onTap: () => Get.toNamed(materialScreen),
          // ),
          const SizedBox(height: 15),
          CustomButton(
            width: width,
            buttonColor: Colors.purple,
            buttonText: "Order",
            // onTap: () => Get.toNamed(orderScreen),
            onTap: () => Get.toNamed(mainOrderScreen),
          ),
          const SizedBox(height: 15),
          CustomButton(
            width: width,
            buttonColor: Colors.purple,
            buttonText: "Daily Usage",
            // onTap: () => Get.toNamed(orderScreen),
            onTap: () => Get.to(DailyUsagePage(siteName: site.siteName!)),
          ),
        ],
      ),
    );
  }
}
