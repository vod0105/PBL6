class UserRegisterDto {
  String fullname;
  String password;
  String phoneNumber;
  String email;
  String address;
  double longTiTuDe;
  double latitude;
  UserRegisterDto(
      {required this.fullname,
      required this.password,
      required this.phoneNumber,
      required this.email,
      required this.longTiTuDe,
      required this.latitude,
      required this.address});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["fullName"] = fullname;
    data["password"] = password;
    data["longtitude"] = longTiTuDe;
    data["latitude"] = latitude;
    data["phoneNumber"] = phoneNumber;
    data["email"] = email;
    data["address"] = address;
    return data;
  }
}
