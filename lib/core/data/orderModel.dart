class Order {
  final String id;
  final String materialName;
  final String supplierName;
  String quantity;
  final String imagePath;
  final String siteName;
  String returnedQuantity;
  String? status = 'pending';
  //pending , approved, returned, received

  Order({
    required this.id,
    required this.materialName,
    required this.supplierName,
    required this.quantity,
    required this.imagePath,
    required this.siteName,
    required this.returnedQuantity,
    this.status
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
      'returnedQuantity': returnedQuantity, // Include new field
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
      returnedQuantity:
      json['returnedQuantity'] ?? '', // Default value for new field
    );
  }
}
