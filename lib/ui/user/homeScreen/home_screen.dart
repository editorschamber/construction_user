import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:site_construct/routes/route.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';
import 'package:site_construct/ui/user/homeScreen/widgets/cards_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currIndex = 0;

  final List<Site> sites = [
    Site(
      imageUrl: 'assets/img/site1.jpg',
      siteName: 'Site 1',
      siteDetails: 'Details about Site 1',
      location: 'Location 1',
    ),
    Site(
      imageUrl: 'assets/img/site2.jpg',
      siteName: 'Site 2',
      siteDetails: 'Details about Site 2',
      location: 'Location 2',
    ),
    Site(
      imageUrl: 'assets/img/site3.jpg',
      siteName: 'Site 3',
      siteDetails: 'Details about Site 3',
      location: 'Location 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
            ),
          ),
        ),
      ),
    );
  }
}
