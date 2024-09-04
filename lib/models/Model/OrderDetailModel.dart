import 'package:android_project/models/Model/ComboModel.dart';
import 'package:android_project/models/Model/ProductModel.dart';

class OrderDetails {
  String? type;
  ProductModel? productDetail;
  ComboModel? comboDetail;

  OrderDetails({this.type, this.productDetail, this.comboDetail});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    productDetail = json['productDetail'] != null
        ? new ProductModel.fromJson(json['productDetail'])
        : null;
    comboDetail = json['comboDetail'] != null
        ? new ComboModel.fromJson(json['comboDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.productDetail != null) {
      data['productDetail'] = this.productDetail!.toJson();
    }
    if (this.comboDetail != null) {
      data['comboDetail'] = this.comboDetail!.toJson();
    }
    return data;
  }
}
