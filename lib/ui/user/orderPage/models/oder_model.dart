import 'package:site_construct/ui/user/homeScreen/models/site.dart';

class Order {
  final String materialName;
  final String supplierName;
  final String quantity;
  final Site site;

  Order({
    required this.materialName,
    required this.supplierName,
    required this.quantity,
    required this.site
  });
}
