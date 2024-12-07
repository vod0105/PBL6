import 'package:android_project/models/Model/Item/ProductItem.dart';

class ProductModel {
  bool? status;
  String? message;
  List<Productitem>? listProduct = [];

  ProductModel({this.status, this.message, this.listProduct});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listProduct = <Productitem>[];
      json['data'].forEach((v) {
        listProduct!.add(Productitem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (listProduct != null) {
      data['data'] = listProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}