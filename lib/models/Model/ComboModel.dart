import 'package:android_project/models/Model/Item/ComboItem.dart';

class ComboModel {
  bool? status;
  String? message;
  List<ComboItem>? listCombo;

  ComboModel({this.status, this.message, this.listCombo});

  ComboModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      listCombo = <ComboItem>[];
      json['data'].forEach((v) {
        listCombo!.add(ComboItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (listCombo != null) {
      data['data'] = listCombo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
