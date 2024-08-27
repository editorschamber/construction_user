import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';
import 'package:site_construct/ui/user/icon/icon_screen.dart';
import '../availableStock/available_stock.dart';
import '../profile/controller/profile_controller.dart';
import '../sitePlans/site_plans.dart';
import '../siteTeam/site_team.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

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

  Site? selectedSite;

  @override
  void initState() {
    super.initState();
    selectedSite = sites[0]; // Set initial site
  }

  void onSiteChanged(Site? site) {
    setState(() {
      selectedSite = site;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/img/person.jpg'),
                      radius: 20,
                    ),
                    Center(
                      child: DropdownButton<Site>(
                        value: selectedSite,
                        onChanged: onSiteChanged,
                        items: sites.map((Site site) {
                          return DropdownMenuItem<Site>(
                            value: site,
                            child: Text(site.siteName),
                          );
                        }).toList(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Get.to(IconScreen());
                      },
                    ),
                  ],
                ),
                // Dropdown to select site

                const SizedBox(height: 20),

                // Site Plans widget updated with selected site
                SitePlans(site: selectedSite),

                const SizedBox(height: 20),

                // Available Stock widget updated with selected site
                AvailableStock(site: selectedSite),

                const SizedBox(height: 20),

                // Site Team widget updated with selected site
                SiteTeam(site: selectedSite),
              ],
            ),
          ),
        ),
      ),
    );
  }
}