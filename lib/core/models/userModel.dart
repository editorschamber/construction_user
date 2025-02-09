import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromMap(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toMap());

List<UserData> userDataListFromMap(String str) =>
    List<UserData>.from(json.decode(str).map((x) => UserData.fromMap(x)));

String userDataListToMap(List<UserData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserData {
  String? userId;
  String? username;
  String? role;
  String? displayName;
  String? phoneNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? password;
  String? profileImage;

  UserData({
    this.userId,
    this.username,
    this.role,
    this.displayName,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.profileImage
  });

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
      userId: json["userId"],
      username: json["username"],
      role: json["role"],
      displayName: json["displayName"],
      phoneNumber: json["phoneNumber"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      password: json["password"],
    profileImage: json["profileImage"].toString()
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "username": username,
    "role": role,
    "displayName": displayName,
    "phoneNumber": phoneNumber,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "password": password
  };
}
