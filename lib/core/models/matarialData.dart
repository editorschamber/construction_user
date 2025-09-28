import 'dart:convert';

List<Materials> materialFromJson(String str) =>
    List<Materials>.from(json.decode(str).map((x) => Materials.fromJson(x)));

String materialToJson(List<Materials> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Materials {
  int? id;
  String? materialName;
  int? approvedQuantity;
  String? unit;

  Materials({
    this.id,
    this.materialName,
    this.approvedQuantity,
    this.unit,
  });

  factory Materials.fromJson(Map<String, dynamic> json) => Materials(
        id: json["id"],
        materialName: json["materialName"],
        approvedQuantity: json["approvedQuantity"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "materialName": materialName,
        "approvedQuantity": approvedQuantity,
        "unit": unit,
      };
}
