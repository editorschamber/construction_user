import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int? id;
  String? materialName;
  String? supplier;
  int? supplierId;
  double? quantity;
  double? returnedQuantity;
  bool? qualityCheck;
  bool? quantityCheck;
  double? price;
  String? status;
  DateTime? orderCreateDate;
  DateTime? expectedDeliveryDate;
  String? deliveryAddress;
  dynamic imagePath;
  dynamic returnReason;
  dynamic returnImage;
  int? siteId;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  SiteData? site;
  SupplierDetails? supplierDetails;
  String? supplierName;
  String? siteName;
  String? instruction;
  String? unit;
  EdByUser? createdByUser;
  EdByUser? approvedByUser;
  EdByUser? receivedByUser;
  EdByUser? returnedByUser;
  EdByUser? rejectedByUser;

  Order({
    this.id,
    this.materialName,
    this.supplier,
    this.supplierId,
    this.quantity,
    this.returnedQuantity,
    this.qualityCheck,
    this.quantityCheck,
    this.price,
    this.status,
    this.orderCreateDate,
    this.expectedDeliveryDate,
    this.deliveryAddress,
    this.imagePath,
    this.returnReason,
    this.returnImage,
    this.siteId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.site,
    this.supplierDetails,
    this.supplierName,
    this.siteName,
    this.instruction,
    this.unit,
    this.createdByUser,
    this.approvedByUser,
    this.receivedByUser,
    this.rejectedByUser,
    this.returnedByUser
  });

  factory Order.fromJson(Map<String, dynamic> json){
    print(json);
    return Order(
      id: json["id"],
      materialName: json["materialName"],
      supplier: json["supplier"],
      supplierId: json["supplierId"],
      quantity: json["quantity"] != null
          ? double.tryParse(json["quantity"].toString())
          : null,
      returnedQuantity: json["returnedQuantity"] != null
          ? double.tryParse(json["returnedQuantity"].toString())
          : null,
      qualityCheck: json["qualityCheck"],
      quantityCheck: json["quantityCheck"],
      price: json["price"] != null
          ? double.tryParse(json["price"].toString())
          : null,
      status: json["status"],
      orderCreateDate: json["orderCreateDate"] == null
          ? null
          : DateTime.parse(json["orderCreateDate"]),
      expectedDeliveryDate: json["expectedDeliveryDate"] == null
          ? null
          : DateTime.parse(json["expectedDeliveryDate"]),
      deliveryAddress: json["deliveryAddress"],
      imagePath: json["imagePath"],
      returnReason: json["returnReason"],
      returnImage: json["returnImage"],
      siteId: json["siteId"],
      userId: json["userId"],
      createdAt:
      json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
      json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      site: json["site"] == null ? null : SiteData.fromJson(json["site"]),
      createdByUser: json["createdByUser"] == null ? null : EdByUser.fromJson(json["createdByUser"]),
      approvedByUser: json["approvedByUser"] == null ? null : EdByUser.fromJson(json["approvedByUser"]),
      receivedByUser: json["receivedByUser"] == null ? null : EdByUser.fromJson(json["receivedByUser"]),
      rejectedByUser: json["rejectedByUser"] == null ? null : EdByUser.fromJson(json["rejectedByUser"]),
      returnedByUser: json["returnedByUser"] == null ? null : EdByUser.fromJson(json["returnedByUser"]),
      supplierDetails: json["supplierDetails"] == null
          ? null
          : SupplierDetails.fromJson(json["supplierDetails"]),
      supplierName: json["supplierName"],
      siteName: json["siteName"],
      instruction: json['instruction'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "materialName": materialName,
    "supplier": supplier,
    "supplierId": supplierId,
    "quantity": quantity,
    "returnedQuantity": returnedQuantity,
    "qualityCheck": qualityCheck,
    "quantityCheck": quantityCheck,
    "price": price,
    "status": status,
    "orderCreateDate": orderCreateDate?.toIso8601String(),
    "expectedDeliveryDate": expectedDeliveryDate?.toIso8601String(),
    "deliveryAddress": deliveryAddress,
    "imagePath": imagePath,
    "returnReason": returnReason,
    "returnImage": returnImage,
    "siteId": siteId,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "site": site?.toJson(),
    "supplierDetails": supplierDetails?.toJson(),
    "supplierName": supplierName,
    "siteName": siteName,
    "instruction": instruction,
    "unit": unit,
  };

  /// **Copy method to update only modified values**
  Order copyWith({
    String? materialName,
    String? supplier,
    int? supplierId,
    double? quantity,
    double? returnedQuantity,
    bool? qualityCheck,
    bool? quantityCheck,
    double? price,
    String? status,
    DateTime? expectedDeliveryDate,
    String? deliveryAddress,
    String? instruction,
    int? siteId
  }) {
    return Order(
      id: id,
      materialName: materialName ?? this.materialName,
      supplier: supplier ?? this.supplier,
      supplierId: supplierId ?? this.supplierId,
      quantity: quantity ?? this.quantity,
      returnedQuantity: returnedQuantity ?? this.returnedQuantity,
      qualityCheck: qualityCheck ?? this.qualityCheck,
      quantityCheck: quantityCheck ?? this.quantityCheck,
      price: price ?? this.price,
      status: status ?? this.status,
      orderCreateDate: orderCreateDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      imagePath: imagePath,
      returnReason: returnReason,
      returnImage: returnImage,
      siteId: siteId,
      userId: userId,
      createdAt: createdAt,
      updatedAt: DateTime.now(), // Updates timestamp on modification
      site: site,
      supplierDetails: supplierDetails,
      supplierName: supplierName,
      siteName: siteName,
      instruction: instruction ?? this.instruction,
      unit: unit,
    );
  }
}

class EdByUser {
  String? userId;
  String? displayName;

  EdByUser({
    this.userId,
    this.displayName,
  });

  factory EdByUser.fromJson(Map<String, dynamic> json) => EdByUser(
    userId: json["userId"],
    displayName: json["displayName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "displayName": displayName,
  };
}

class SiteData {
  int? id;
  String? siteName;

  SiteData({
    this.id,
    this.siteName,
  });

  factory SiteData.fromJson(Map<String, dynamic> json) => SiteData(
    id: json["id"],
    siteName: json["siteName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "siteName": siteName,
  };
}

class SupplierDetails {
  int? id;
  String? supplierName;

  SupplierDetails({
    this.id,
    this.supplierName,
  });

  factory SupplierDetails.fromJson(Map<String, dynamic> json) =>
      SupplierDetails(
        id: json["id"],
        supplierName: json["supplierName"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "supplierName": supplierName,
  };
}