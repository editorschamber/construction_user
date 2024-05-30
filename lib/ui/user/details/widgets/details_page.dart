import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

import '../../../../routes/route.dart';
import '../../homeScreen/models/site.dart';

class DetailsPage extends StatelessWidget {
  final Site site;

  const DetailsPage({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          site.imageUrl, // Replace with your image URL
          height: height * 0.3,
          width: width,
          fit: BoxFit.cover,
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
        const SizedBox(height: 15),
        CustomButton(
          width: width,
          buttonColor: Colors.purple,
          buttonText: "Material Details",
          onTap: () {},
        ),
      ],
    );
  }
}
