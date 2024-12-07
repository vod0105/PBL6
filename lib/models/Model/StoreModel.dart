import 'package:android_project/models/Model/Item/StoresItem.dart';

class StoresModel {
  bool? status;
  String? message;
  List<StoresItem>? listStores;

  StoresModel({this.status, this.message, this.listStores});

  StoresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listStores = <StoresItem>[];
      json['data'].forEach((v) {
        listStores!.add(StoresItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (listStores != null) {
      data['data'] = listStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}