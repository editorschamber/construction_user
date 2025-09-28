import 'dart:convert';

List<MaterialQuantity> materialQuantityFromJson(String str) =>
    List<MaterialQuantity>.from(
        json.decode(str).map((x) => MaterialQuantity.fromJson(x)));

String materialQuantityToJson(List<MaterialQuantity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialQuantity {
  int? id;
  String? materialName;
  int? quantity;
  int? siteId;
  dynamic price;
  String? userId;
  String? unit;
  DateTime? createdAt;
  DateTime? updatedAt;

  MaterialQuantity({
    this.id,
    this.materialName,
    this.quantity,
    this.siteId,
    this.price,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.unit,
  });

  factory MaterialQuantity.fromJson(Map<String, dynamic> json) =>
      MaterialQuantity(
        id: json["id"],
        materialName: json["materialName"],
        quantity: json["quantity"],
        siteId: json["siteId"],
        price: json["price"],
        userId: json["userId"],
        unit: json["unit"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "materialName": materialName,
        "quantity": quantity,
        "siteId": siteId,
        "price": price,
        "userId": userId,
        "unit": unit,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
