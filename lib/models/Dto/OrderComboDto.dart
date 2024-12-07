class OrderComboDto {
  String? paymentMethod;
  int? comboId;
  List<int>? drinkIds;
  int? storeId;
  int? quantity;
  String? size;
  String? deliveryAddress;
  double? latitude;
  double? longitude;
  String? discountCode;

  OrderComboDto({
    this.paymentMethod,
    this.comboId,
    this.drinkIds,
    this.storeId,
    this.quantity,
    this.size,
    this.deliveryAddress,
    this.discountCode,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethod'] = paymentMethod;
    data['comboId'] = comboId;
    data['drinkId'] = drinkIds;
    data['storeId'] = storeId;
    data['quantity'] = quantity;
    data['discountCode'] = discountCode;
    data['size'] = size;
    data['deliveryAddress'] = deliveryAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
