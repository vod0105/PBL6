
class ComboModel {
  int? comboId;
  String? comboName;
  String? image;
  double? comboPrice;
  ComboModel({
    required this.comboId,
    required this.comboName,
    required this.image,
    required this.comboPrice,
  });
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = new Map<String, dynamic>();

    map["comboId"] = this.comboId;
    map["comboName"] = this.comboName;
    map["image"] = this.image;
    map["comboPrice"] = this.comboPrice;

    return map;
  }

  late List<ComboModel> _combos;
  List<ComboModel> get combos => _combos;

  ComboModel.fromJson(Map<String,dynamic> json){
    comboId = json['comboId'];
    comboName = json['comboName'];
    image = json['image'];
    comboPrice = json['price'];
    if(json['data'] != null){
      _combos = <ComboModel>[];
      json['data'].forEach((v) {
        _combos.add(ComboModel.fromJson(v));
      });
    }
  }


}