class CartModel {
  bool? status;
  String? message;
  List<CartData>? data = [];

  CartModel({this.status, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? cartId;
  String? type;
  ProductInCart? product;
  ComboInCart? combo;

  CartData({this.cartId, this.type, this.product, this.combo});

  CartData.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    type = json['type'];
    product = json['product'] != null
        ? ProductInCart.fromJson(json['product'])
        : null;
    combo =
        json['combo'] != null ? ComboInCart.fromJson(json['combo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartId'] = cartId;
    data['type'] = type;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['combo'] = combo;
    return data;
  }
}

class ProductInCart {
  int? userId;
  int? productId;
  String? productName;
  String? image;
  
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  int? storeId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? size;
  ProductInCart(
      {this.userId,
      this.productId,
      this.productName,
      this.image,
      this.quantity,
      this.unitPrice,
      
      this.totalPrice,
      this.storeId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.size});

  ProductInCart.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    productId = json['productId'];
    productName = json['productName'];
    image = json['image'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
   
    storeId = json['storeId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['productId'] = productId;
    data['productName'] = productName;
    
    data['image'] = image;
    data['quantity'] = quantity;
    data['unitPrice'] = unitPrice;
    data['totalPrice'] = totalPrice;
    data['storeId'] = storeId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['size'] = size;
    return data;
  }
}

class ComboInCart {
  int? userId;
  int? comboId;
  String? comboName;
  String? image;
  List<int>? drinkId;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  int? storeId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? size;
  ComboInCart(
      {this.userId,
      this.comboId,
      this.comboName,
      this.image,
      this.quantity,
      this.drinkId,
      this.unitPrice,
      this.totalPrice,
      this.storeId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.size});

  ComboInCart.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    comboId = json['comboId'];
    comboName = json['comboName'];
    image = json['image'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    storeId = json['storeId'];
     if (json['drinkId'] != null) {
      drinkId = <int>[];
      json['drinkId'].forEach((v) {
        drinkId!.add(v);
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['comboId'] = comboId;
    data['comboName'] = comboName;
    data['image'] = image;
    data['quantity'] = quantity;
    data['unitPrice'] = unitPrice;
    if (drinkId != null) {
      data['drinkId'] = drinkId!.map((v) => v.toString()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['storeId'] = storeId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['size'] = size;
    return data;
  }
}
