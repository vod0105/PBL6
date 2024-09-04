import 'package:android_project/models/Model/RoleModels.dart';
class Usermodel {
  int? id;
  String? phoneNumber;
  String? fullName;
  String? avatar;
  String? email;
  String? address;
  String? createdAt;
  String? updatedAt;
  bool? accountLocked;
  Rolemodels? role;

  Usermodel(
      {this.id,
      this.phoneNumber,
      this.fullName,
      this.avatar,
      this.email,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.accountLocked,
      this.role});

  Usermodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    email = json['email'];
    address = json['address'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accountLocked = json['accountLocked'];
    role = json['role'] != null ? new Rolemodels.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['address'] = this.address;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['accountLocked'] = this.accountLocked;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}