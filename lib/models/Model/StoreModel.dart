class StoreModel {
  int? storeId;
  String? storeName;
  String? location;
  double? longitude;
  double? latitude;
  String? numberPhone;
  String? openingTime;
  String? closingTime;
  String? managerName;
  String? createdAt;
  String? updatedAt;

  StoreModel(
      {this.storeId,
      this.storeName,
      this.location,
      this.longitude,
      this.latitude,
      this.numberPhone,
      this.openingTime,
      this.closingTime,
      this.managerName,
      this.createdAt,
      this.updatedAt}
    );

  
  late List<StoreModel> _stores;
  List<StoreModel> get stores => _stores;

  StoreModel.fromJson(Map<String,dynamic> json){
    storeId = json['storeId'];
    storeName = json['storeName'];
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    numberPhone = json['numberPhone'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    managerName = json['managerName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if(json['data'] != null){
      _stores = <StoreModel>[];
      json['data'].forEach((v) {
        _stores.add(StoreModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['location'] = this.location;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['numberPhone'] = this.numberPhone;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['managerName'] = this.managerName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}