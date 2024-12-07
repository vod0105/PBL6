class UserUpdateDto {
  String fullName;
  String  avatar;
  String email;
  String address;
  UserUpdateDto(
      {required this.fullName,
      required this.avatar,
      required this.email,
      required this.address});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["fullName"] = fullName;
    data["avatar"] = avatar;
    data["email"] = email;
    data["address"] = address;
    return data;
  }
}
