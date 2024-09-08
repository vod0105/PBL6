import 'package:android_project/models/Model/CategoryModel.dart';
import 'package:android_project/models/Model/StoreModel.dart';

class ProductModel {
  int? productId;
  String? productName;
  String? image;
  String? description;
  double? price;
  double? discountedPrice;
  Categorymodel? category;
  List<StoreModel>? stores;
  int? stockQuantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? bestSale;


  ProductModel({
    required this.productId,
    required this.productName,
    required this.image,
    required this.description,
    required this.price,
    required this.discountedPrice,
    required this.category,
    required this.stores,
    required this.stockQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.bestSale,
  });
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    image = json['image'];
    description = json['description'];
    price = json['price']?.toDouble();
    discountedPrice = json['discountedPrice']?.toDouble();
    category = json['category'] is Map<String, dynamic>
        ? Categorymodel.fromJson(json['category'])
        : null;

    if (json['stores'] != null) {
      stores = [];
      json['stores'].forEach((v) {
        stores!.add(StoreModel.fromJson(v));
      });
    }

    stockQuantity = json['stockQuantity'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null;
    updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null;
    bestSale = json['bestSale'];
    if (json['data'] != null && json['data'] is List) {
      _products = <ProductModel>[];
      json['data'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
  }

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
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['bestSale'] = bestSale;
    return data;
  }
}
