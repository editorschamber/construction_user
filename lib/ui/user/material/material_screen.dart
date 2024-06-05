import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/material/widgets/material_details.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  List<Map<String, String>> members = [
    {'stockName': 'Stock Name'},
    // Add initial members if needed
  ];

  void _addMember(String name) {
    setState(() {
      members.add({'stockName': name});
    });
  }

  void _showAddMemberDialog() {
    String name = '';

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
                if (name.isNotEmpty) {
                  _addMember(name);
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
        title: const Text('Material Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: MaterialDetails(
            members: members,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
