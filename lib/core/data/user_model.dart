class UserModel {
  final String phoneNumber;

  UserModel({required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      phoneNumber: map['phoneNumber'],
    );
  }
}
