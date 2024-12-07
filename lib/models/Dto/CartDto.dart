class CartDto {
  List<int> cartList;
  String deliveryAddress;
  String paymentMethod;
  double latitude;
  double longitude;
  String? discountCode;
  CartDto(
      {required this.cartList,
      required this.latitude,
      required this.longitude,
      required this.deliveryAddress,
      required this.paymentMethod,
      this.discountCode});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["cartIds"] = cartList;
    data["deliveryAddress"] = deliveryAddress;
    data["paymentMethod"] = paymentMethod;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["discountCode"] = discountCode;
    return data;
  }
}
