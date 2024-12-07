class UserDto {
  String username;
  String password;
  UserDto({
    required this.username,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["numberPhone"] = username;
    data["password"] = password;
    return data;
  }
}
