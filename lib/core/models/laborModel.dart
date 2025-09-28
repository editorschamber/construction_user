import 'dart:convert';

List<AttendanceModel> attendanceFromJson(String str) =>
    List<AttendanceModel>.from(
        json.decode(str).map((x) => AttendanceModel.fromJson(x)));

String attendanceToJson(List<AttendanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceModel {
  final String id;
  final String laborName;
  final int siteId;
  final String markedBy;
  String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceModel(
      {required this.id,
      required this.laborName,
      required this.siteId,
      required this.markedBy,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      AttendanceModel(
        id: json['id'] ?? '',
        laborName: json['laborName'],
        siteId: json['siteId'] ?? 0,
        markedBy: json['markedBy'] ?? '',
        status: json['status'] ?? 'IN',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'laborName': laborName,
        'siteId': siteId,
        'markedBy': markedBy,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
