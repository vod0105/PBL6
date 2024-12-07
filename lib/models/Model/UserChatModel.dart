import 'package:android_project/models/Model/UserModel.dart';

class UserChatModel {
  bool? status;
  String? message;
  List<User>? listUser;

  UserChatModel({this.status, this.message, this.listUser});

  UserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listUser = <User>[];
      json['data'].forEach((v) {
        listUser!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
   if (listUser != null) {
      data['data'] = listUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
