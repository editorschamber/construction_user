import 'package:get_storage/get_storage.dart';

class UserModel {
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String phoneNumber;

  UserModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumber,
  });

  // Convert a UserModel object into a map
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }

  // Convert a map into a UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
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