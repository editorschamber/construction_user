import 'package:flutter/material.dart';

class SiteEmployeeDetails extends StatefulWidget {
  const SiteEmployeeDetails({super.key});

  @override
  State<SiteEmployeeDetails> createState() => _SiteEmployeeDetailsState();
}

class _SiteEmployeeDetailsState extends State<SiteEmployeeDetails> {
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
