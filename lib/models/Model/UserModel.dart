class UserModel {
  bool? status;
  String? message;
  User? user;

  UserModel({this.status, this.message, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['data'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? phoneNumber;
  String? fullName;
  String? avatar;
  double? longitude;
  double? latitude;
  String? email;
  String? address;
  String? createdAt;
  String? updatedAt;
  bool? accountLocked;
  Role? role;

  User(
      {this.id,
      this.phoneNumber,
      this.fullName,
      this.avatar,
      this.email,
      this.address,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt,
      this.accountLocked,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    email = json['email'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accountLocked = json['accountLocked'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['avatar'] = avatar;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['email'] = email;
    data['address'] = address;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['accountLocked'] = accountLocked;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
