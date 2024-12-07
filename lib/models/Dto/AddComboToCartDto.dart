class ComboToCartDto {
  int? comboId;
  int? quantity;
  int? storeId;
  String? size;
  String? status;
  List<int>? drinkId;
  ComboToCartDto({
    this.comboId,
    this.drinkId,
    this.quantity,
    this.storeId,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comboId'] = comboId;
    data['quantity'] = quantity;
    data['size'] = "M";
    data['storeId'] = storeId;
    data['status'] = "Pending";
    data['drinkId'] = drinkId;
    return data;
  }
}
