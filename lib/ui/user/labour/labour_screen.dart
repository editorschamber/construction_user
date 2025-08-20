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
  List<AttendanceModel> allMembers = [];
  SelectedSiteNotifier siteNotifier = SelectedSiteNotifier.getInstance();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    fetchAllLabors();
    getData();
    super.initState();
  }

  Future<void> _addMember(String name) async {
    // setState(() {
    //   members.add({'name': name});
    // });
    if (name.isEmpty) {
      Get.snackbar("Error", "Name cannot be empty");
      return;
    }
    if (members.any((m) => m.laborName.toLowerCase() == name.toLowerCase() && DateTime.now().difference(m.createdAt).inDays == 0)) {
      Get.snackbar("Error", "Attendance already marked for $name today");
      return;
    }

    var response = await AttendanceService().addLaborAttendance([
      {"labourName": name, "status": "IN"
      }
    ], siteNotifier.value);
    if(response != null){
      Navigator.of(context).pop();
      Get.snackbar("Success", "Attendance marked for $name successfully");
      getData();
    } else {
      Get.snackbar("Error", "Attendance not marked for $name ");
    }
  }

  Future<void> fetchAllLabors() async {
    var response = await AttendanceService().getAllLabors(siteNotifier.value);
    if (response != null) {
      setState(() {
        allMembers = response;
      });
    } else {
      Get.snackbar("Error", "Failed to fetch labour data");
    }
  }

  void _showAddMemberDialog() {
    String filter = '';
    String? selectedName;

    final List<String> allNames = allMembers.skipWhile((x){
      print(members.indexWhere((y) => (y.laborName == x.laborName) && DateTime.now().difference(y.createdAt).inDays == 0) != -1);
      return members.indexWhere((y) => (y.laborName == x.laborName) && DateTime.now().difference(y.createdAt).inDays == 0) != -1;

    })
        .map((e) => (e.laborName).toString().trim())
        .toSet()
        .toList();

    print(allNames);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            final filtered = allNames
                .where((n) => n.toLowerCase().contains(filter.toLowerCase()))
                .toList();

            return AlertDialog(
              title: const Text('Add or Select Member'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue tev) {
                      final q = tev.text.trim().toLowerCase();
                      if (q.isEmpty) {
                        // show nothing until user types; change to `return allNames` if you want full list on focus
                        return const Iterable<String>.empty();
                      }
                      return allNames.where((n) => n.toLowerCase().contains(q));
                    },
                    fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
                      // keep the current text in `filter` and also derive button state
                      textController.addListener(() {
                        setStateSB(() {
                          filter = textController.text.trim();
                        });
                      });
                      return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          labelText: 'Search or type name',
                          hintText: '',
                        ),
                        onSubmitted: (_) => onFieldSubmitted(),
                      );
                    },
                    onSelected: (String selection) {
                      setStateSB(() {
                        selectedName = selection;
                        filter = selection; // keep button label in sync
                      });
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Align(
                          widthFactor: 0.75,
                          alignment: Alignment.center,
                          child: Material(
                            elevation: 4,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return ListTile(
                                  dense: true,
                                  title: Text(option),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(selectedName != null &&
                      allNames.any((n) =>
                      n.toLowerCase() == selectedName!.toLowerCase())
                      ? 'Select'
                      : 'Add'),
                  onPressed: () {
                    final nameToAdd = selectedName ?? filter;
                    if (nameToAdd.isEmpty) return;
                    _addMember(nameToAdd);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Labours'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Attendance'),
              Tab(text: 'All Labours'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // Tab 1: Existing UI (unchanged)
              Column(
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
                            ) ??
                                DateTime.now();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: LabourDetails(
                      showInOutButton: true,
                      members: members
                      // Step 1: same-day filter
                          .where((m) => m.createdAt.difference(selectedDate).inDays == 0)
                      // Step 2: fold into Map<String, AttendanceModel>
                          .fold<Map<String, AttendanceModel>>({}, (map, m) {
                        map.putIfAbsent(m.laborName, () => m);
                        return map;
                      })
                      // Step 3: convert back to List<AttendanceModel>
                          .values
                          .toList(),
                    ),
                  ),
                ],
              ),

              // Tab 2: All Labours
              Column(
                children: [
                  Expanded(
                    child: LabourDetails(
                      showInOutButton: false,
                      members: allMembers
                      // keep only one per labourName (latest occurrence kept)
                          .fold<Map<String, AttendanceModel>>({}, (map, m) {
                        map[m.laborName] = m;
                        return map;
                      })
                          .values
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddMemberDialog,
          child: const Icon(Icons.add),
        ),
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

