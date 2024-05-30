import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/labour/widgets/labour_details.dart';

class LabourScreen extends StatefulWidget {
  const LabourScreen({super.key});

  @override
  State<LabourScreen> createState() => _LabourScreenState();
}

class _LabourScreenState extends State<LabourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labour Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const LabourDetails();
                })),
      ),
    );
  }
}
