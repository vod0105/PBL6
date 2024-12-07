class Orderproductdto {
  String? paymentMethod;
  int? productId;
  int? storeId;
  int? quantity;
  String? size;
  String? deliveryAddress;
  double? latitude;
  double? longitude;
  String? discountCode;

  Orderproductdto(
      {this.paymentMethod,
      this.productId,
      this.storeId,
      this.quantity,
      this.size,
      this.deliveryAddress,
      this.discountCode,
      this.latitude,
      this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethod'] = paymentMethod;
    data['productId'] = productId;
    data['discountCode'] = discountCode;
    data['storeId'] = storeId;
    data['quantity'] = quantity;
    data['size'] = size;
    data['deliveryAddress'] = deliveryAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
