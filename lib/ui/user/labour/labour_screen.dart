import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/labour/widgets/labour_details.dart';

class LabourScreen extends StatefulWidget {
  const LabourScreen({super.key});

  @override
  State<LabourScreen> createState() => _LabourScreenState();
}

class _LabourScreenState extends State<LabourScreen> {
  List<Map<String, String>> members = [
    {'name': 'John Doe', 'site': 'xyz', 'job': 'xyz'},
    // Add initial members if needed
  ];

  void _addMember(String name, String site, String job) {
    setState(() {
      members.add({'name': name, 'site': site, 'job': job});
    });
  }

  void _showAddMemberDialog() {
    String name = '';
    String site = '';
    String job = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Site Name'),
                onChanged: (value) {
                  site = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Job Title'),
                onChanged: (value) {
                  job = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (name.isNotEmpty && site.isNotEmpty && job.isNotEmpty) {
                  _addMember(name, site, job);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labour Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: LabourDetails(members: members),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
