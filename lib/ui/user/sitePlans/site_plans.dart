import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import '../../../routes/route.dart';
import '../allSitePlan/all_site_plans_screen.dart';

class SitePlans extends StatelessWidget {
  final Site? site;

  const SitePlans({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    if (site == null) return Container(); // Handle null case

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
            onTap: () => Get.toNamed(detailsScreen, arguments: site),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Hero(
                      tag: site!.siteName,
                      child: Image.asset(
                        site!.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
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
                              site!.siteName,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                const Icon(Icons.maps_home_work),
                                const SizedBox(height: 5),
                                Text(site!.location),
                              ],
                            ),
                          ],
                        ),
                        Text(site!.siteDetails)
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