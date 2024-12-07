import 'package:android_project/models/Model/Item/CategoryItem.dart';

class CategoryModel {
  bool? status;
  String? message;
  List<CategoryItem>? listCategory;

  CategoryModel({this.status, this.message, this.listCategory});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listCategory = <CategoryItem>[];
      json['data'].forEach((v) {
        listCategory!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (listCategory != null) {
      data['data'] = listCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
