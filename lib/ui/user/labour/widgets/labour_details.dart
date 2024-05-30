import 'package:flutter/material.dart';

class LabourDetails extends StatefulWidget {
  const LabourDetails({super.key});

  @override
  State<LabourDetails> createState() => _LabourDetailsState();
}

class _LabourDetailsState extends State<LabourDetails> {
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
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/img/person.jpg"),
          ),
          title: Text(
            'Labour Name',
          ),
          subtitle: Text("address"),
          trailing: Icon(Icons.call),
        ),
      ),
    );
  }
}
