import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:site_construct/apiServices/attendanceService.dart';
import 'package:site_construct/core/models/laborModel.dart';
import 'package:site_construct/core/notifiers/selectedSiteNotifier.dart';
import 'package:site_construct/ui/user/labour/widgets/labour_details.dart';

class LabourScreen extends StatefulWidget {
  const LabourScreen({super.key});

  @override
  State<LabourScreen> createState() => _LabourScreenState();
}

class _LabourScreenState extends State<LabourScreen> {
  List<AttendanceModel> members = [];
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> _addMember(String name) async {
    // setState(() {
    //   members.add({'name': name});
    // });

    var response = await AttendanceService().addLaborAttendance([
      {"labourName": name, "status": "IN"
      }
    ], siteNotifier.value);
    if(response != null){
      Navigator.of(context).pop();
      Get.snackbar("Success", "Attendance marked for $name successfully");
    } else {
      Get.snackbar("Error", "Attendance not marked for $name ");
    }
  }

  void _showAddMemberDialog() {
    String name = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              )
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (name.isNotEmpty) {
                  _addMember(name);

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
        title: const Text('Labours'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${DateFormat.yMMMd().format(selectedDate)}'),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      ) ?? DateTime.now();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: LabourDetails(members: members.takeWhile((m) => m.createdAt.difference(selectedDate).inDays == 0).toList())),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        child: const Icon(Icons.add),
      ),
    );
  }



  getData() async{
    var response = await AttendanceService().getLabourAttendance(siteNotifier.value);
    setState(() {
      members = response;
    });
  }
}

