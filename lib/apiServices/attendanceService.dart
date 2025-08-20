import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';
import 'package:site_construct/core/models/laborModel.dart';

import '../core/models/supervisorAttendanceModel.dart';
import 'apiServices.dart';

class AttendanceService{

  final apiService = APIServices();
  // Admin login
  Future<Map<String, dynamic>> markAttendance(image, siteId, status) async {
    var data = {
      'siteId': siteId,
      'status': status
    };
    print("image $data");
    final response = await apiService.postApi(
      APIStrings.markAttendance,
      body: json.encode({
        'image': image,
        'siteId': siteId,
        'status': status
      }),
    );

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<Map<String, dynamic>> addLaborAttendance(labors, siteId) async {
    var data = labors.map((l) {
      if (l is Map<String, dynamic>) {
        return {...l, "siteId": siteId};
      } else {
        return l.toJson()..['siteId'] = siteId;
      }
    }).toList();
    print("image $data");
    final response = await apiService.postApi(
      APIStrings.laborAttendance,
      body: jsonEncode({"attendances": data}),
    );

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to log in');
    }
  }

  // Verify JWT token
  Future<List<AttendanceModel>> getLabourAttendance(siteId) async {
    final response = await apiService.getApi(
      APIStrings.getLaborAttendance,
      params: {
        "siteId": siteId
      }
    );

    if (response != null) {
      return attendanceFromJson(jsonEncode(response["attendance"]));
    } else {
      throw Exception('Failed to verify token');
    }
  }

  Future<List<AttendanceModel>> getAllLabors(siteId) async {
    final response = await apiService.getApi(
      APIStrings.getAllLabors,
      params: {
        "siteId": siteId,
      }
    );

    if (response != null) {
      print(response);
      return attendanceFromJson(jsonEncode(response['data']));
    } else {
      throw Exception('Failed to verify token');
    }
  }

  Future<List<AttendanceModel>> getLabourAttendanceByName(name) async {
    final response = await apiService.getApi(
      APIStrings.getAttendanceByName,
      params: {
        "laborName": name
      }
    );

    if (response != null) {
      return attendanceFromJson(jsonEncode(response["attendance"]));
    } else {
      throw Exception('Failed to verify token');
    }
  }

  Future<SupervisorAttendanceModel> getSupervisorAttendance(userId) async {
    final response = await apiService.getApi(
        "${APIStrings.supervisorAttendance}",
        params: {"userId": userId});

    if (response != null) {
      print("getSites data is ${response}");

      return SupervisorAttendanceModel.fromJson(response);
    } else {
      throw Exception('Failed to load getSites data');
    }
  }


  Future<Map<String, dynamic>> markAsOut(String id, String siteId) async {
    final response = await apiService.postApi(
      APIStrings.markAsOut,
      body: jsonEncode({
          "id": id,
          "siteId": siteId,
        })
    );

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to delete attendance');
    }
  }
}