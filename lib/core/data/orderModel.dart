class Order {
  final String? id;
  final String materialName;
  final String supplierName;
  String quantity;
  String imagePath;
  final String siteName;
  String returnedQuantity;
  String? status = 'pending';
  DateTime? orderCreateDate;
  DateTime? expectedDeliveryDate;
  bool? materialCheck = false;
  bool? quantityCheck = false;
  bool? packagingCheck = false;
  //pending , approved, returned, received

  Order({
    required this.id,
    required this.materialName,
    required this.supplierName,
    required this.quantity,
    required this.imagePath,
    required this.siteName,
    required this.returnedQuantity,
    this.status,
    this.orderCreateDate,
    this.expectedDeliveryDate,
    this.materialCheck,
    this.quantityCheck,
    this.packagingCheck,

  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'materialName': materialName,
      'supplierName': supplierName,
      'quantity': quantity,
      'imagePath': imagePath,
      'siteName': siteName,
      'status': status,
      'returnedQuantity': returnedQuantity,
      'materialCheck': materialCheck,
      'quantityCheck': quantityCheck,
      'packagingCheck': packagingCheck,
      'orderCreateDate': orderCreateDate?.toIso8601String(),
      'expectedDeliveryDate': expectedDeliveryDate?.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      materialName: json['materialName'],
      supplierName: json['supplierName'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
      siteName: json['siteName'] ?? '',
      status: json['status'],
      materialCheck: json['materialCheck'],
      quantityCheck: json['quantityCheck'],
      packagingCheck: json['packagingCheck'],
      returnedQuantity:
      json['returnedQuantity'] ?? '',
      orderCreateDate: json['orderCreateDate'] != null
          ? DateTime.parse(json['orderCreateDate'])
          : null, // Parse if not null
      expectedDeliveryDate: json['expectedDeliveryDate'] != null
          ? DateTime.parse(json['expectedDeliveryDate'])
          : null,
    );
  }
}
