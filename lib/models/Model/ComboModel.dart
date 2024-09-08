
class ComboModel {
  int? comboId;
  String? comboName;
  String? image;
  double? comboPrice;
  String? description;
  ComboModel({
    required this.comboId,
    required this.comboName,
    required this.image,
    required this.comboPrice,
    required this.description,
  });
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = new Map<String, dynamic>();

    map["comboId"] = this.comboId;
    map["comboName"] = this.comboName;
    map["image"] = this.image;
    map["comboPrice"] = this.comboPrice;
    map["description"] = this.description;

    return map;
  }

  late List<ComboModel> _combos;
  List<ComboModel> get combos => _combos;

  ComboModel.fromJson(Map<String,dynamic> json){
    comboId = json['comboId'];
    comboName = json['comboName'];
    image = json['image'];
    description = json['description'];
    comboPrice = json['price'];
    if(json['data'] != null){
      _combos = <ComboModel>[];
      json['data'].forEach((v) {
        _combos.add(ComboModel.fromJson(v));
      });
    }
  }


}