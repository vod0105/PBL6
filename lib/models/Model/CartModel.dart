import 'package:android_project/models/Model/ComboModel.dart';
import 'package:android_project/models/Model/ProductModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:flutter/material.dart';

class Cartmodel {
  int? cartItemId;
  int ? userId;
  int? productId;
  String? productName;
  String ? image;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  int? storeId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Cartmodel ({
    required this.cartItemId,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.image,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.storeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  List<Cartmodel> _carts = [];
  List<Cartmodel> get carts => _carts;
  Cartmodel.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cartItemId'];
    userId = json['userId '];
    productId = json['productId'];
    productName = json['productName'];
    image = json['image'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    storeId = json['storeId'];
    if (json['status'] is bool) {
      status = json['status'] ? 'active' : 'inactive'; 
    } else if (json['status'] is String) {
      status = json['status'];
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['data'] != null && json['data'] is List) {
      _carts = <Cartmodel>[];
      json['data'].forEach((v) {
        _carts.add(Cartmodel.fromJson(v));
      });
  }

}


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartItemId'] = cartItemId;
    data['userId'] = userId;
    data['productId'] = productId;
    data['productName'] = productName;
    data['image'] = image;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['unitPrice'] = unitPrice;
    data['totalPrice'] = totalPrice;
    data['storeId'] = storeId;
    data['status'] = status;
    return data;
  }
}