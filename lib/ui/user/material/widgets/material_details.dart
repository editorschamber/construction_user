import 'package:flutter/material.dart';

class MaterialDetails extends StatefulWidget {
  const MaterialDetails({super.key});

  @override
  State<MaterialDetails> createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(14),
        ),
        child: const ListTile(
          title: Text(
            'Material Name',
          ),
          trailing: Icon(Icons.shopping_bag),
        ),
      ),
    );
  }
}
