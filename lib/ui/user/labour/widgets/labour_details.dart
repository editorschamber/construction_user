import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_construct/apiServices/attendanceService.dart';
import 'package:site_construct/core/models/laborModel.dart';
import 'package:site_construct/core/notifiers/selectedSiteNotifier.dart';
import 'package:site_construct/ui/user/labour/widgets/labour_attendance.dart';
import 'package:site_construct/utils/common/common_widgets/custom_button.dart';

class LabourDetails extends StatefulWidget {
  final List<AttendanceModel> members;
  final bool showInOutButton;

  const LabourDetails(
      {super.key, required this.members, required this.showInOutButton});

  @override
  State<LabourDetails> createState() => _LabourDetailsState();
}

class _LabourDetailsState extends State<LabourDetails> {
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: widget.members.length, // Number of items in the grid
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to details page if needed
              Get.to(() =>
                  LabourAttendance(name: widget.members[index].laborName));
            },
            child: widget.showInOutButton
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      tileColor: Colors.grey.shade200,
                      title: Text(
                        '${widget.members[index].laborName}',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Marked By: ${widget.members[index].markedBy}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Text(
                        widget.members[index].status,
                        style: TextStyle(
                          color: widget.members[index].status == 'IN'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: widget.members[index].status == "IN"
                          ? IconButton(
                              onPressed: () {
                                AttendanceService attendanceService =
                                    AttendanceService();
                                attendanceService
                                    .markAsOut(widget.members[index].id,
                                        siteNotifier.value.toString())
                                    .then((response) {
                                  if (response != null) {
                                    setState(() {
                                      widget.members[index].status = 'OUT';
                                    });
                                    Get.snackbar("Success",
                                        "Marked as OUT successfully");
                                  } else {
                                    Get.snackbar(
                                        "Error", "Failed to mark as OUT");
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.output_sharp,
                                color: Colors.red,
                              ))
                          : null,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                        tileColor: Colors.grey.shade200,
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          radius: 16,
                          child: Text(
                            widget.members[index].laborName.isNotEmpty
                                ? widget.members[index].laborName[0]
                                    .toUpperCase()
                                : '?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          '${widget.members[index].laborName}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        trailing: CustomButton(
                            buttonText: "Attendance",
                            buttonColor: Colors.purple,
                            height: 30,
                            onTap: () {
                              Get.to(() => LabourAttendance(
                                  name: widget.members[index].laborName));
                            })),
                  ),
          );
        },
      ),
    );
  }
}

// show attendace by labor name of whole month
