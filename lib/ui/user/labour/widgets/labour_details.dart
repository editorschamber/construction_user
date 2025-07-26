import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_construct/core/models/laborModel.dart';

class LabourDetails extends StatefulWidget {
  final List<AttendanceModel> members;

  const LabourDetails({super.key, required this.members});

  @override
  State<LabourDetails> createState() => _LabourDetailsState();
}

class _LabourDetailsState extends State<LabourDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          // crossAxisSpacing: 8.0, // Spacing between columns
          // mainAxisSpacing: 8.0, // Spacing between rows
          childAspectRatio: 2, // Aspect ratio of each grid item
        ),
        itemCount: widget.members.length, // Number of items in the grid
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${widget.members[index].laborName}', style: TextStyle(fontWeight: FontWeight.w700),),
                  Text('Marked By: ${widget.members[index].markedBy}', overflow: TextOverflow.ellipsis,),
                  Text('Date: ${DateFormat.yMMMd().format(widget.members[index].createdAt)}', overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
