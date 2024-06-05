import 'package:flutter/material.dart';

class SiteTeam extends StatelessWidget {
  const SiteTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Site Team', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                // Navigate to view all screen
              },
              child: Text('View All'),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TeamMember(role: 'Plumber'),
              TeamMember(role: 'Electrician'),
              TeamMember(role: 'Engineer'),
              TeamMember(role: 'Engineer'),
            ],
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
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 30),
          ),
          SizedBox(height: 8.0),
          Text(role, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
