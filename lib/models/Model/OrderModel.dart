class OrderModel {
  bool? status;
  String? message;
  List<OrderItem>? orderItem = [];

  OrderModel({this.status, this.message, this.orderItem});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      orderItem = <OrderItem>[];
      json['data'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    }
  }
  OrderModel.fromAJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      orderItem = <OrderItem>[];
      orderItem!.add(OrderItem.fromJson(json['data']));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderItem != null) {
      data['data'] = orderItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  int? orderId;
  String? orderCode;
  int? userId;
  String? orderDate;
  double? totalAmount;
  int? shipperId;
  String? status;
  String? deliveryAddress;
  String? createdAt;
  String? updatedAt;
  bool? feedback;
  double? longitude;
  double? latitude;
  List<OrderDetails>? orderDetails;

  OrderItem(
      {this.orderId,
      this.orderCode,
      this.userId,
      this.longitude,
      this.latitude,
      this.shipperId,
      this.orderDate,
      this.totalAmount,
      this.status,
      this.deliveryAddress,
      this.createdAt,
      this.updatedAt,
      this.feedback,
      this.orderDetails});

  OrderItem.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderCode = json['orderCode'];
    userId = json['userId'];
    shipperId = json['shipperId'];
    orderDate = json['orderDate'];
    totalAmount = json['totalAmount'];
    status = json['status'];
    deliveryAddress = json['deliveryAddress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    feedback = json['feedBack'];
    if (json['orderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderCode'] = orderCode;
    data['shipperId'] = shipperId;
    data['userId'] = userId;
    data['orderDate'] = orderDate;
    data['totalAmount'] = totalAmount;
    data['status'] = status;
    data['deliveryAddress'] = deliveryAddress;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['feedBack'] = feedback;
    if (orderDetails != null) {
      data['orderDetails'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String? type;
  ProductDetail? productDetail;
  ComboDetail? comboDetail;

  OrderDetails({this.type, this.productDetail, this.comboDetail});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    productDetail = json['productDetail'] != null
        ? ProductDetail.fromJson(json['productDetail'])
        : null;
    comboDetail = json['comboDetail'] != null
        ? ComboDetail.fromJson(json['comboDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (productDetail != null) {
      data['productDetail'] = productDetail!.toJson();
    }
    if (comboDetail != null) {
      data['comboDetail'] = comboDetail!.toJson();
    }
    return data;
  }
}

class ProductDetail {
  int? orderDetailId;
  int? productId;
  String? productName;
  String? description;
  String? productImage;
  String? category;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  String? size;
  List<String>? drinkId;
  int? storeId;
  String? status;
  bool? bestSeller;

  ProductDetail(
      {this.orderDetailId,
      this.productId,
      this.productName,
      this.description,
      this.productImage,
      this.category,
      this.quantity,
      this.unitPrice,
      this.totalPrice,
      this.size,
      this.drinkId,
      this.storeId,
      this.status,
      this.bestSeller});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['orderDetailId'];
    productId = json['productId'];
    productName = json['productName'];
    description = json['description'];
    productImage = json['productImage'];
    category = json['category'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    size = json['size'];
    if (json['drinkId'] != null) {
      drinkId = <String>[];
      json['drinkId'].forEach((v) {
        drinkId!.add(v.toString());
      });
    }
    storeId = json['storeId'];
    status = json['status'];
    bestSeller = json['bestSeller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderDetailId'] = orderDetailId;
    data['productId'] = productId;
    data['productName'] = productName;
    data['description'] = description;
    data['productImage'] = productImage;
    data['category'] = category;
    data['quantity'] = quantity;
    data['unitPrice'] = unitPrice;
    data['totalPrice'] = totalPrice;
    data['size'] = size;
    if (drinkId != null) {
      data['drinkId'] = drinkId!.map((v) => v.toString()).toList();
    }
    data['storeId'] = storeId;
    data['status'] = status;
    data['bestSeller'] = bestSeller;
    return data;
  }
}

class ComboDetail {
  int? orderDetailId;
  int? comboId;
  int? quantity;
  double? unitPrice;
  double? totalPrice;
  String? size;
  List<String>? drinkId;
  int? storeId;
  String? status;

  ComboDetail({
    this.orderDetailId,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.size,
    this.drinkId,
    this.storeId,
    this.status,
  });

  ComboDetail.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['orderDetailId'];
    comboId = json['comboId'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    size = json['size'];
     if (json['drinkId'] != null) {
      drinkId = <String>[];
      json['drinkId'].forEach((v) {
        drinkId!.add(v.toString());
      });
    }
    storeId = json['storeId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderDetailId'] = orderDetailId;
    data['comboId'] = comboId;
    data['quantity'] = quantity;
    data['unitPrice'] = unitPrice;
    data['totalPrice'] = totalPrice;
    data['size'] = size;
    if (drinkId != null) {
      data['drinkId'] = drinkId!.map((v) => v.toString()).toList();
    }
    data['storeId'] = storeId;
    data['status'] = status;
    return data;
  }
}
