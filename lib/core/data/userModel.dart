import 'package:get_storage/get_storage.dart';

class UserModel {
  String username;
  String phoneNumber;

  UserModel({
    // required this.name,
    required this.username,
    required this.phoneNumber,
  });

  // Convert a UserModel object into a map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }

  // Convert a map into a UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // name: json['name'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Save user data to local storage
  void saveToStorage() {
    final box = GetStorage();
    box.write('user', toJson());
  }

  // Read user data from local storage
  static UserModel? readFromStorage() {
    final box = GetStorage();
    if (box.hasData('user')) {
      return UserModel.fromJson(box.read('user'));
    }
    return null;
  }
}