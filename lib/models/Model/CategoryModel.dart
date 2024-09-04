class Categorymodel {
  int? categoryId;
  String? categoryName;
  String? description;
  String? image;
  Categorymodel({
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.image,
  });
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = new Map<String, dynamic>();

    map["categoryId"] = this.categoryId;
    map["categoryName"] = this.categoryName;
    map["description"] = this.description;
    map["image"] = this.image;

    return map;
  }

  late List<Categorymodel> _categories;
  List<Categorymodel> get categories => _categories;

  Categorymodel.fromJson(Map<String,dynamic> json){
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    description = json['description'];
    image = json['image'];
    if(json['data'] != null){
      _categories = <Categorymodel>[];
      json['data'].forEach((v) {
        _categories.add(Categorymodel.fromJson(v));
      });
    }
  }
}