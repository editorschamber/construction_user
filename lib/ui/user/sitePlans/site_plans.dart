import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';

import '../../../routes/route.dart';
import '../allSitePlan/all_site_plans_screen.dart';

class SitePlans extends GetView {
  final List<Site> sites;

  const SitePlans({super.key, required this.sites});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Site Plans',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(detailsScreen, arguments: sites[1]),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      sites[1].imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sites[1].siteName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                const Icon(Icons.maps_home_work),
                                const SizedBox(height: 5),
                                Text(sites[1].location),
                              ],
                            ),
                          ],
                        ),
                        Text(sites[1].siteDetails)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
