import 'package:flutter/material.dart';

class LabourDetails extends StatefulWidget {
  final List<Map<String, String>> members;

  const LabourDetails({super.key, required this.members});

  @override
  State<LabourDetails> createState() => _LabourDetailsState();
}

class _LabourDetailsState extends State<LabourDetails> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
        childAspectRatio: 0.7, // Aspect ratio of each grid item
      ),
      itemCount: widget.members.length, // Number of items in the grid
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Icon(Icons.person, size: 50),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text('Name: ${widget.members[index]['name']}'),
                Text('Site Name: ${widget.members[index]['site']}'),
                Text('Job: ${widget.members[index]['job']}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
