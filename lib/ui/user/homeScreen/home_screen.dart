import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/ui/user/homeScreen/models/site.dart';

import '../availableStock/available_stock.dart';
import '../sitePlans/site_plans.dart';
import '../siteTeam/site_team.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/img/person.jpg'),
                      radius: 20,
                    ),
                    const Text('Hello John Doe', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SitePlans(sites: sites),
                const SizedBox(height: 20),
                AvailableStock(),
                const SizedBox(height: 20),
                SiteTeam(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
