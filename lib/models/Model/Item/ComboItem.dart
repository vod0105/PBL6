import 'package:android_project/models/Model/Item/ProductItem.dart';

class Comboitem {
  int? comboId;
  String? comboName;
  double? price;
  String? image;
  String? description;
  List<Productitem>? products;

  Comboitem(
      {this.comboId,
      this.comboName,
      this.price,
      this.image,
      this.description,
      this.products});

  Comboitem.fromJson(Map<String, dynamic> json) {
    comboId = json['comboId'];
    comboName = json['comboName'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    if (json['products'] != null) {
      products = <Productitem>[];
      json['products'].forEach((v) {
        products!.add(new Productitem.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comboId'] = this.comboId;
    data['comboName'] = this.comboName;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
