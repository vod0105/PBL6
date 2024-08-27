class Userregisterdto {
  String fullname;
  String password;
  String phonenumber;
  String email;
  String address;
  Userregisterdto({
    required this.fullname,
    required this.password,
    required this.phonenumber,
    required this.email,
    required this.address
  });
  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["fullName"] = this.fullname;
    data["password"] = this.password;
    data["phoneNumber"] = this.phonenumber;
    data["email"] = this.email;
    data["address"] = this.address;
    return data;

  }
}