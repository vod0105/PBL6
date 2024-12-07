import 'package:android_project/models/Model/UserModel.dart';

class RateModel {
  bool? success;
  String? message;
  List<RateData>? listRate;

  RateModel({this.success, this.message, this.listRate});

  RateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      listRate = <RateData>[];
      json['data'].forEach((v) {
        listRate!.add(RateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (listRate != null) {
      data['data'] = listRate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DisplayRate{
  User? user;
  RateData? rateData;
  DisplayRate({
    this.user,
    this.rateData,
  });
}
class RateData {
  int? rateId;
  int? userId;
  int? rate;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? productId;
  int? comboId;
  List<String>? imageRatings;

  RateData(
      {this.rateId,
      this.userId,
      this.rate,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.productId,
      this.comboId,
      this.imageRatings});

  RateData.fromJson(Map<String, dynamic> json) {
    rateId = json['rateId'];
    userId = json['userId'];
    rate = json['rate'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    productId = json['productId'];
    comboId = json['comboId'];
    imageRatings = json['imageRatings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rateId'] = rateId;
    data['userId'] = userId;
    data['rate'] = rate;
    data['comment'] = comment;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['productId'] = productId;
    data['comboId'] = comboId;
    data['imageRatings'] = imageRatings;
    return data;
  }
}
