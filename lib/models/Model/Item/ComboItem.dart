import 'package:android_project/models/Model/Item/ProductItem.dart';

class ComboItem {
  int? comboId;
  String? comboName;
  double? price;
  double? averageRate;
  String? image;
  String? description;
  List<Productitem>? products;

  ComboItem(
      {this.comboId,
      this.comboName,
      this.price,
      this.averageRate,
      this.image,
      this.description,
      this.products});

  ComboItem.fromJson(Map<String, dynamic> json) {
    comboId = json['comboId'];
    comboName = json['comboName'];
    price = json['price'];
    averageRate = json['averageRate'];
    image = json['image'];
    description = json['description'];
    if (json['products'] != null) {
      products = <Productitem>[];
      json['products'].forEach((v) {
        products!.add(Productitem.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comboId'] = comboId;
    data['comboName'] = comboName;
    data['averageRate'] = averageRate;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
