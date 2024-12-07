import 'package:android_project/models/Model/Item/CategoryItem.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';

class Productitem {
  int? productId;
  String? productName;
  String? image;
  String? description;
  double? price;
  double? discountedPrice;
  double? averageRate;
  CategoryItem? category;
  List<StoresItem>? stores;
  int? stockQuantity;
  String? createdAt;
  String? updatedAt;
  bool? bestSale;

  Productitem(
      {this.productId,
      this.productName,
      this.image,
      this.description,
      this.price,
      this.discountedPrice,
      this.averageRate,
      this.category,
      this.stores,
      this.stockQuantity,
      this.createdAt,
      this.updatedAt,
      this.bestSale});

  Productitem.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    discountedPrice = json['discountedPrice'];
    averageRate = json['averageRate'];
    category = json['category'] != null
        ? CategoryItem.fromJson(json['category'])
        : null;
    if (json['stores'] != null) {
      stores = <StoresItem>[];
      json['stores'].forEach((v) {
        stores!.add(StoresItem.fromJson(v));
      });
    }
    stockQuantity = json['stockQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bestSale = json['bestSale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['image'] = image;
    data['description'] = description;
    data['price'] = price;
    data['discountedPrice'] = discountedPrice;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    data['stockQuantity'] = stockQuantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['bestSale'] = bestSale;
    return data;
  }
}
