class Order {
  final String materialName;
  final String supplierName;
  String quantity;
  final String imagePath;
  final bool isReceivedOrder;
  final String siteName;
  bool isReturn;
  String returnedQuantity; // New field
  String? status = 'pending';

  Order({
    required this.materialName,
    required this.supplierName,
    required this.quantity,
    required this.imagePath,
    this.isReceivedOrder = false,
    required this.siteName,
    required this.isReturn,
    required this.returnedQuantity,
    this.status
  });

  Map<String, dynamic> toJson() {
    return {
      'materialName': materialName,
      'supplierName': supplierName,
      'quantity': quantity,
      'imagePath': imagePath,
      'isReceivedOrder': isReceivedOrder,
      'siteName': siteName,
      'isReturn': isReturn,
      'status': status,
      'returnedQuantity': returnedQuantity, // Include new field
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      materialName: json['materialName'],
      supplierName: json['supplierName'],
      quantity: json['quantity'],
      imagePath: json['imagePath'],
      isReceivedOrder: json['isReceivedOrder'] ?? false,
      siteName: json['siteName'] ?? '',
      isReturn: json['isReturn'],
      status: json['status'],
      returnedQuantity:
      json['returnedQuantity'] ?? '', // Default value for new field
    );
  }
}
