import 'package:android_project/models/Model/UserModel.dart';

class ChartModel {
  List<UserChart>? listUser;
  int? eC;
  String? eM;

  ChartModel({this.listUser, this.eC, this.eM});

  ChartModel.fromJson(Map<String, dynamic> json) {
    if (json['DT'] != null) {
      listUser = <UserChart>[];
      json['DT'].forEach((v) {
        listUser!.add(UserChart.fromJson(v));
      });
    }
    eC = json['EC'];
    eM = json['EM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listUser != null) {
      data['DT'] = listUser!.map((v) => v.toJson()).toList();
    }
    data['EC'] = eC;
    data['EM'] = eM;
    return data;
  }
}

class UserChart {
  int? id;
  String? phoneNumber;
  String? fullName;
  String? avatar;
  String? email;
  String? address;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? updatedAt;
  bool? accountLocked;
  bool? isActive;
  Role? role;

  UserChart(
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
      this.isActive,
      this.role});

  UserChart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    email = json['email'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    accountLocked = json['accountLocked'];
    isActive = json['isActive'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['avatar'] = avatar;
    data['email'] = email;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['accountLocked'] = accountLocked;
    data['isActive'] = isActive;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}
