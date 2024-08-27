import 'package:get/get.dart';

class StaticData {
  static final RxMap<String, List<MaterialModel>> siteMaterials = <String, List<MaterialModel>>{
    'Site 1': [
      MaterialModel(name: 'Steel', quantity: 3100),
      MaterialModel(name: 'Brick', quantity: 3100),
    ],
    'Site 2': [
      MaterialModel(name: 'Steel', quantity: 2500),
      MaterialModel(name: 'Brick', quantity: 5000),
    ],
    'Site 3': [
      MaterialModel(name: 'Steel Brick', quantity: 4000),
      MaterialModel(name: 'Concrete', quantity: 2000),
    ],
  }.obs;
}

class MaterialModel {
  String name;
  double quantity;

  MaterialModel({required this.name, required this.quantity});
}