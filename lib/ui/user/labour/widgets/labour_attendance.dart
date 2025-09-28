// implement UI for showing labour attendance by labor name and whole month (site Id not required)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:site_construct/apiServices/attendanceService.dart';
import '../../../../core/models/laborModel.dart';

class _DayRow {
  final DateTime date;
  final DateTime? inTime;
  final DateTime? outTime;
  final bool present;
  _DayRow(
      {required this.date, this.inTime, this.outTime, required this.present});
}

class LabourAttendance extends StatefulWidget {
  final String name;

  const LabourAttendance({Key? key, required this.name}) : super(key: key);

  @override
  State<LabourAttendance> createState() => _LabourAttendanceState();
}

class _LabourAttendanceState extends State<LabourAttendance> {
  List<AttendanceModel> attendanceRecords = [];
  DateTime selectedDate = DateTime.now();

  String _fmtDate(DateTime d) => DateFormat('dd-MM-yyyy').format(d);
  String _fmtTime(DateTime? t) =>
      t == null ? '-' : DateFormat('HH:mm').format(t);

  List<_DayRow> _buildMonthRows() {
    // Start from the first day of the current month
    final now = DateTime.now();
    final DateTime start = DateTime(now.year, now.month, 1);

    // Determine the latest date in attendance; fallback to today if empty
    DateTime lastDate = start;
    for (final r in attendanceRecords) {
      final d = DateTime(r.createdAt.year, r.createdAt.month, r.createdAt.day);
      if (d.isAfter(lastDate)) lastDate = d;
    }
    if (attendanceRecords.isEmpty) {
      lastDate = now;
    }

    bool sameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    // Filter to range [start, lastDate]
    final rangeRecords = attendanceRecords.where((r) {
      final d = DateTime(r.createdAt.year, r.createdAt.month, r.createdAt.day);
      return !d.isBefore(start) && !d.isAfter(lastDate);
    }).toList();

    // Group by day key
    String keyOf(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    final Map<String, List<AttendanceModel>> byDay = {};
    for (final r in rangeRecords) {
      final d = DateTime(r.createdAt.year, r.createdAt.month, r.createdAt.day);
      byDay.putIfAbsent(keyOf(d), () => <AttendanceModel>[]).add(r);
    }

    // Walk from start to lastDate, one day at a time
    final List<_DayRow> rows = [];
    DateTime cursor = start;
    while (!cursor.isAfter(lastDate)) {
      final k = keyOf(cursor);
      final daily = byDay[k] ?? const <AttendanceModel>[];

      DateTime? inTime;
      DateTime? outTime;
      bool present = false;

      for (final rec in daily) {
        final status = rec.status.toString().toUpperCase();
        final t = rec.createdAt;
        inTime = rec.createdAt;
        present = true;
        if (status == "OUT") {
          outTime = rec.updatedAt;
        }
      }

      rows.add(_DayRow(
          date: cursor, inTime: inTime, outTime: outTime, present: present));
      cursor = cursor.add(const Duration(days: 1));
    }

    return rows;
  }

  @override
  void initState() {
    super.initState();
    fetchAttendanceRecords();
  }

  Future<void> fetchAttendanceRecords() async {
    var response =
        await AttendanceService().getLabourAttendanceByName(widget.name);
    if (response != null) {
      setState(() {
        attendanceRecords = response;
      });
    } else {
      Get.snackbar("Error", "Failed to fetch attendance records");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance for ${widget.name}'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 600),
              child: SingleChildScrollView(
                child: Builder(
                  builder: (context) {
                    final rows = _buildMonthRows();
                    return DataTable(
                      headingRowHeight: 44,
                      dataRowMinHeight: 44,
                      columns: const [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('In')),
                        DataColumn(label: Text('Out')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: [
                        for (final r in rows)
                          DataRow(cells: [
                            DataCell(Text(_fmtDate(r.date.toLocal()))),
                            DataCell(Text(_fmtTime(r.inTime?.toLocal()))),
                            DataCell(Text(_fmtTime(r.outTime?.toLocal()))),
                            DataCell(
                              Text(
                                r.present ? 'Present' : 'Absent',
                                style: TextStyle(
                                  color: r.present ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ]),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
