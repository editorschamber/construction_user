import 'dart:convert';
import 'package:site_construct/apiServices/apiStrings.dart';
import 'package:site_construct/core/models/laborModel.dart';

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
}