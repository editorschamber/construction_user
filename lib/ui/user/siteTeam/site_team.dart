import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/core/data/site.dart';

class SiteTeam extends StatelessWidget {
  final Site? site;

  const SiteTeam({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    if (site == null) return Container(); // Handle null case

    // Dummy team data based on the selected site
    final teamData = {
      'Site 1': ['Plumber', 'Electrician', 'Engineer'],
      'Site 2': ['Carpenter', 'Painter', 'Engineer'],
      'Site 3': ['Plumber', 'Mason', 'Engineer'],
    };

    final siteTeam = teamData[site!.siteName] ?? [];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Site Team',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                // Get.to(ViewAllTeamScreen());
              },
              child: const Text('View All'),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: siteTeam.map((role) {
              return TeamMember(role: role);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class TeamMember extends StatelessWidget {
  final String role;

  const TeamMember({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 30),
          ),
          const SizedBox(height: 8.0),
          Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
