class Rolemodels {
  int? id;
  String? name;
  Rolemodels({
    required this.id,
    required this.name
  });

  Map<String , dynamic> toJson(){
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = this.id;
    map['name'] = this.name;

    return map;
  }
  
  Rolemodels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}