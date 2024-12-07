class RegisterShipperDto {
  String? name;
  String? citizenID;
  String? imageCitizenFront;
  String? imageCitizenBack;
  String? email;
  String? phone;
  String? address;
  String? birthday;
  String? vehicle;
  String? licensePlate;
  String? driverLicense;
  RegisterShipperDto({
    required this.name,
    required this.citizenID,
    required this.imageCitizenFront,
    required this.imageCitizenBack,
    required this.email,
    required this.phone,
    required this.address,
    required this.birthday,
    required this.vehicle,
    required this.licensePlate,
    required this.driverLicense,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
      data["name"] =  name;
      data["citizenID"] =  citizenID;
      data["imageCitizenFront"] =  imageCitizenFront;
      data["imageCitizenBack"] =  imageCitizenBack;
      data["email"] =  email;
      data["phone"] =  phone;
      data["address"] =  address;
      data["age"] =  int.parse(birthday!);
      data["vehicle"] =  vehicle;
      data["licensePlate"] =  licensePlate;
      data["driverLicense"] =  driverLicense;
    return data;
  }
}
