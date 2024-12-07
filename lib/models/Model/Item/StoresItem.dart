class StoresItem {
  int? storeId;
  String? storeName;
  String? image;
  String? location;
  double? longitude;
  double? latitude;
  String? numberPhone;
  String? openingTime;
  String? closingTime;
  int? managerId;
  String? createdAt;
  String? updatedAt;

  StoresItem(
      {this.storeId,
      this.storeName,
      this.image,
      this.location,
      this.longitude,
      this.latitude,
      this.numberPhone,
      this.openingTime,
      this.closingTime,
      this.managerId,
      this.createdAt,
      this.updatedAt});

  StoresItem.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    storeName = json['storeName'];
    image = json['image'];
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    numberPhone = json['numberPhone'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    managerId = json['managerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['storeName'] = storeName;
    data['image'] = image;
    data['location'] = location;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['numberPhone'] = numberPhone;
    data['openingTime'] = openingTime;
    data['closingTime'] = closingTime;
    data['managerId'] = managerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
