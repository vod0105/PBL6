class ZaloModels {
  bool? success;
  String? message;
  ZaloData? zaloData;

  ZaloModels({this.success, this.message, this.zaloData});

  ZaloModels.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    zaloData = json['data'] != null ? ZaloData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (zaloData != null) {
      data['data'] = zaloData!.toJson();
    }
    return data;
  }
}

class ZaloData {
  String? returnMessage;
  String? orderUrl;
  int? returnCode;
  String? zpTransToken;
  String? appTransId;
  String? orderId;

  ZaloData(
      {this.returnMessage,
      this.orderUrl,
      this.returnCode,
      this.zpTransToken,
      this.appTransId,
      this.orderId});

  ZaloData.fromJson(Map<String, dynamic> json) {
    returnMessage = json['returnmessage'];
    orderUrl = json['orderurl'];
    returnCode = json['returncode'];
    zpTransToken = json['zptranstoken'];
    appTransId = json['apptransid'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['returnmessage'] = returnMessage;
    data['orderurl'] = orderUrl;
    data['returncode'] = returnCode;
    data['zptranstoken'] = zpTransToken;
    data['apptransid'] = appTransId;
    data['order_id'] = orderId;
    return data;
  }
}