// To parse this JSON data, do
//
//     final supplierData = supplierDataFromJson(jsonString);

import 'dart:convert';

List<SupplierData> supplierDataFromJson(String str) => List<SupplierData>.from(
    json.decode(str).map((x) => SupplierData.fromJson(x)));

String supplierDataToJson(List<SupplierData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplierData {
  int? id;
  String? supplierName;
  String? address;
  String? contact;
  String? whatsupNo;
  String? gst;

  SupplierData(
      {this.supplierName,
      this.address,
      this.contact,
      this.whatsupNo,
      this.gst,
      this.id});

  factory SupplierData.fromJson(Map<String, dynamic> json) => SupplierData(
        id: json['id'],
        supplierName: json["supplierName"],
        address: json["address"],
        contact: json["contact"],
        whatsupNo: json["whatsupNo"],
        gst: json["gst"],
      );

  Map<String, dynamic> toJson() => {
        "supplierName": supplierName,
        "address": address,
        "contact": contact,
        "whatsupNo": whatsupNo,
        "gst": gst,
      };
}
