class AddCartDto {
  int? productId;
  int? quantity;
  String? size;
  int? storeId;

  AddCartDto({this.productId, this.quantity, this.size, this.storeId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['size'] = size;
    data['storeId'] = storeId;
    return data;
  }
}