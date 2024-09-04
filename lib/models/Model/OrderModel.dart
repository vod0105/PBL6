import 'package:android_project/models/Model/OrderDetailModel.dart';

class Ordermodel {
  int? orderId;
  String? orderCode;
  int? userId;
  int? storeId;
  String? orderDate;
  double? totalAmount;
  String? status;
  String? paymentMethod;
  String? deliveryAddress;
  String? createdAt;
  String? updatedAt;
  List<OrderDetails>? orderDetails;

  Ordermodel(
      {this.orderId,
      this.orderCode,
      this.userId,
      this.storeId,
      this.orderDate,
      this.totalAmount,
      this.status,
      this.paymentMethod,
      this.deliveryAddress,
      this.createdAt,
      this.updatedAt,
      this.orderDetails});

  late List<Ordermodel> _orders;
  List<Ordermodel> get orders => _orders;

  Ordermodel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderCode = json['orderCode'];
    userId = json['userId'];
    storeId = json['storeId'];
    orderDate = json['orderDate'];
    totalAmount = json['totalAmount'];
    status = json['status']?.toString();
    paymentMethod = json['paymentMethod'];
    deliveryAddress = json['deliveryAddress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    if(json['data'] != null){
      _orders = <Ordermodel>[];
      json['data'].forEach((v) {
        _orders.add(Ordermodel.fromJson(v));
      });
    }

    if (json['orderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderCode'] = this.orderCode;
    data['userId'] = this.userId;
    data['storeId'] = this.storeId;
    data['orderDate'] = this.orderDate;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    data['paymentMethod'] = this.paymentMethod;
    data['deliveryAddress'] = this.deliveryAddress;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
