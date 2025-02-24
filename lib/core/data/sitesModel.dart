// To parse this JSON data, do
//
//     final sitesModel = sitesModelFromJson(jsonString);

import 'dart:convert';

SitesModel sitesModelFromJson(String str) =>
    SitesModel.fromJson(json.decode(str));

String sitesModelToJson(SitesModel data) => json.encode(data.toJson());

class SitesModel {
  bool? success;
  List<Sites>? data;

  SitesModel({
    this.success,
    this.data,
  });

  factory SitesModel.fromJson(Map<String, dynamic> json) => SitesModel(
        success: json["success"],
        data: List<Sites>.from(json["data"].map((x) => Sites.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? {}),
      };
}

class Sites {
  int? id;
  String? siteName;
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  String? imageUrl;
  String? userId;

  Sites({
    this.id,
    this.siteName,
    this.location,
    this.startDate,
    this.endDate,
    this.imageUrl,
    this.userId,
  });

  // factory Sites.fromJson(Map<String, dynamic> json) => Sites(
  //       id: json["id"],
  //       siteName: json["siteName"],
  //       location: json["location"],
  //       startDate: DateTime.parse(json["startDate"]),
  //       endDate: DateTime.parse(json["endDate"]),
  //       imageUrl: json["imageUrl"],
  //       userId: json["userId"],
  //     );

  factory Sites.fromJson(Map<String, dynamic> json) => Sites(
        id: json["id"],
        siteName: json["siteName"] ?? '', // Handle null values
        location: json["location"] ?? '',
        startDate: json["startDate"] != null
            ? DateTime.tryParse(json["startDate"])
            : null,
        endDate:
            json["endDate"] != null ? DateTime.tryParse(json["endDate"]) : null,
        imageUrl: json["imageUrl"] ?? '',
        userId: json["userId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "siteName": siteName,
        "location": location,
        "startDate": startDate,
        "endDate": endDate,
        "imageUrl": imageUrl,
        "userId": userId,
      };
}
