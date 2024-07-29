import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';

import '../../../routes/route.dart';
import '../allSitePlan/all_site_plans_screen.dart';

class SitePlans extends StatelessWidget {
  final List<Site> sites;

  const SitePlans({super.key, required this.sites});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     const Text(
        //       'Site Plans',
        //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //     ),
        //     TextButton(
        //       onPressed: () {
        //         Get.to(
        //           transition: Transition.rightToLeft,
        //           () => AllSitePlansScreen(sites: sites),
        //         );
        //       },
        //       child: const Text('View All'),
        //     ),
        //   ],
        // ),
        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 8.0,
        //     mainAxisSpacing: 8.0,
        //     childAspectRatio: 0.8,
        //   ),
        //   itemCount: sites.length,
        //   itemBuilder: (context, index) {
        //     return GestureDetector(
        //       onTap: () {
        //         Get.toNamed('/detailsScreen', arguments: sites[index]);
        //       },
        //       child: Card(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Expanded(
        //               child: Image.asset(
        //                 sites[index].imageUrl,
        //                 fit: BoxFit.cover,
        //                 width: double.infinity,
        //               ),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     sites[index].siteName,
        //                     style: const TextStyle(fontWeight: FontWeight.bold),
        //                   ),
        //                   Text(sites[index].siteDetails),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
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
                Image.asset(
                  sites[1].imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
    );
  }
}
