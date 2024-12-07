class MoMoModels {
  String? requestType;
  String? orderId;
  String? signature;
  String? requestId;
  String? qrCodeUrl;
  String? deepLink;
  int? errorCode;
  String? payUrl;
  String? deepLinkWebInApp;
  String? message;
  String? localMessage;
  MoMoModels(
      {this.requestType,
      this.orderId,
      this.signature,
      this.requestId,
      this.qrCodeUrl,
      this.deepLink,
      this.errorCode,
      this.payUrl,
      this.deepLinkWebInApp,
      this.message,
      this.localMessage});

 late MoMoModels moMo;
  MoMoModels.fromJson(Map<String, dynamic> json) {
    requestType = json['requestType'];
    orderId = json['orderId'];
    signature = json['signature'];
    requestId = json['requestId'];
    qrCodeUrl = json['qrCodeUrl'];
    deepLink = json['deeplink'];
    errorCode = json['errorCode'];
    payUrl = json['payUrl'];
    deepLinkWebInApp = json['deeplinkWebInApp'];
    message = json['message'];
    localMessage = json['localMessage'];
    if(json['data'] != null){
      moMo = MoMoModels();
      moMo =  MoMoModels.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestType'] = requestType;
    data['orderId'] = orderId;
    data['signature'] = signature;
    data['requestId'] = requestId;
    data['qrCodeUrl'] = qrCodeUrl;
    data['deeplink'] = deepLink;
    data['errorCode'] = errorCode;
    data['payUrl'] = payUrl;
    data['deeplinkWebInApp'] = deepLinkWebInApp;
    data['message'] = message;
    data['localMessage'] = localMessage;
    return data;
  }
}
