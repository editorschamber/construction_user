import 'dart:convert';

List<SiteData> siteDataFromJson(String str) =>
    List<SiteData>.from(json.decode(str).map((x) => SiteData.fromJson(x)));

String siteDataToJson(List<SiteData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiteData {
  int? id;
  String? siteName;
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  String? imageUrl;
  String? userId;

  SiteData({
    this.id,
    this.siteName,
    this.location,
    this.startDate,
    this.endDate,
    this.imageUrl,
    this.userId,
  });

  factory SiteData.fromJson(Map<String, dynamic> json) => SiteData(
        id: json["id"],
        siteName: json["siteName"],
        location: json["location"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        imageUrl: json["imageUrl"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "siteName": siteName,
        "location": location,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "imageUrl": imageUrl,
        "userId": userId,
      };
}
