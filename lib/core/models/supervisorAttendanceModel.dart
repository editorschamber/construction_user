class SupervisorAttendanceModel {
  List<Attendance>? attendance;

  SupervisorAttendanceModel({this.attendance});

  SupervisorAttendanceModel.fromJson(Map<String, dynamic> json) {
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  String? id;
  String? userId;
  String? image;
  int? siteId;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  ConstructionSite? constructionSite;

  Attendance(
      {this.id,
      this.userId,
      this.image,
      this.siteId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.constructionSite});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    image = json['image'];
    siteId = json['siteId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    constructionSite = json['ConstructionSite'] != null
        ? new ConstructionSite.fromJson(json['ConstructionSite'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['siteId'] = this.siteId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    if (this.constructionSite != null) {
      data['ConstructionSite'] = this.constructionSite!.toJson();
    }
    return data;
  }
}

class User {
  String? userId;
  String? displayName;
  String? role;

  User({this.userId, this.displayName, this.role});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    displayName = json['displayName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['displayName'] = this.displayName;
    data['role'] = this.role;
    return data;
  }
}

class ConstructionSite {
  int? id;
  String? siteName;
  String? location;

  ConstructionSite({this.id, this.siteName, this.location});

  ConstructionSite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['siteName'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['siteName'] = this.siteName;
    data['location'] = this.location;
    return data;
  }
}
