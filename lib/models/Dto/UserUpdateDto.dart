import 'package:get/get.dart';

class Userupdatedto {
  String fullname;
  MultipartFile avatar;
  String email;
  String address;
  Userupdatedto(
      {required this.fullname,
      required this.avatar,
      required this.email,
      required this.address});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["fullName"] = this.fullname;
    data["avatar"] = this.avatar;
    data["email"] = this.email;
    data["address"] = this.address;
    return data;
  }
}
