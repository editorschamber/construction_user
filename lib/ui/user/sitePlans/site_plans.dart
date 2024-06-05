import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/homeScreen/widgets/cards_page.dart';
import 'package:site_construct/routes/route.dart';

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
            Text('Site Plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                // Navigate to view all screen
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
            childAspectRatio: 0.7,
          ),
          itemCount: sites.length,
          itemBuilder: (context, index) {
            return CardsPage(
              site: sites[index],
              onTap: () {
                Get.toNamed(detailsScreen, arguments: sites[index]);
              },
            );
          },
        ),
      ],
    );
  }
}
