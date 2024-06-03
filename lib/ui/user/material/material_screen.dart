import 'package:flutter/material.dart';
import 'package:site_construct/ui/user/material/widgets/material_details.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const MaterialDetails();
                })),
      ),
    );
  }
}
