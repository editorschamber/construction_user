import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';

import '../allSitePlan/all_site_plans_screen.dart';

class SitePlans extends StatelessWidget {
  final List<Site> sites;

  const SitePlans({super.key, required this.sites});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Site Plans',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            TextButton(
              onPressed: () {
                Get.to(
                    transition: Transition.rightToLeft,
                    () => AllSitePlansScreen(sites: sites),);
              },
              child: Text('View All'),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: sites.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed('/detailsScreen', arguments: sites[index]);
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        sites[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sites[index].siteName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(sites[index].siteDetails),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
