import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:site_construct/apiServices/apiStrings.dart';

class APIServices {
  final http.Client client = http.Client();

  Future<dynamic> getApi(String endpoint,
      {Map<String, dynamic>? params, dynamic body, String? authToken}) async {
    final Uri url = Uri.parse(APIStrings.baseUrl + endpoint);
    // String? authToken = '${APIStrings.authToken}';
    try {
      final http.Response response;
      response = await client.get(
        url,
        headers: {
          // 'Authorization': '$authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> PostApi(String endpoint,
      {Map<String, dynamic>? params, dynamic body}) async {
    final Uri url = Uri.parse(APIStrings.baseUrl + endpoint);
    // String authToken = APIStrings.authToken;

    try {
      final http.Response response;
      response = await client.post(
        url,
        headers: {
          // 'Authorization': authToken,
          'Content-Type': 'application/json',
        },
        body: body,
      );

      log("POST API REQUEST IS $endpoint : ${body}");
      log(" POST API RESPONSE is $endpoint : ${response.body}");

      if (response.statusCode == 200) {
        log(" POST API RESPONSE is $endpoint : ${response.body}");
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> DeleteApi(String endpoint,
      {Map<String, dynamic>? params, dynamic body}) async {
    final Uri url = Uri.parse(APIStrings.baseUrl + endpoint);
    // String? authToken = '${APIStrings.authToken}';

    try {
      final http.Response response;
      response = await client.delete(
        url,
        headers: {
          // 'Authorization': '$authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<dynamic> putApi(String endpoint,
      {Map<String, dynamic>? params, dynamic body}) async {
    final Uri url = Uri.parse(APIStrings.baseUrl + endpoint);
    // String? authToken = '${APIStrings.authToken}';

    try {
      final http.Response response;
      response = await client.put(
        url,
        headers: {
          // 'Authorization': '$authToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
