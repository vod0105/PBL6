class PromotionModel {
  bool? success;
  String? message;
  List<PromotionData>? listPromotion;

  PromotionModel({this.success, this.message, this.listPromotion});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      listPromotion = <PromotionData>[];
      json['data'].forEach((v) {
        listPromotion!.add(PromotionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (listPromotion != null) {
      data['data'] = listPromotion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromotionData {
  int? voucherId;
  List<int>? storeId;
  String? code;
  double? discountPercent;
  String? description;
  String? startDate;
  String? endDate;
  bool? used;

  PromotionData(
      {this.voucherId,
      this.storeId,
      this.code,
      this.discountPercent,
      this.description,
      this.startDate,
      this.endDate,
      this.used
      });

  PromotionData.fromJson(Map<String, dynamic> json) {
    voucherId = json['voucherId'];
    storeId = json['storeId'].cast<int>();
    code = json['code'];
    discountPercent = json['discountPercent'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    used = json['used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voucherId'] = voucherId;
    data['storeId'] = storeId;
    data['code'] = code;
    data['discountPercent'] = discountPercent;
    data['description'] = description;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['used'] = used;
    return data;
  }
}