class SizeModel {
  bool? status;
  String? message;
  List<Size>? listSize;


  SizeModel({this.status, this.message, this.listSize});

  SizeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listSize = <Size>[];
      json['data'].forEach((v) {
        listSize!.add(Size.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (listSize != null) {
      data['data'] = listSize!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  int? id;
  String? name;

  Size({this.id, this.name});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}