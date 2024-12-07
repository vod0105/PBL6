class AnnounceModel {
  bool? success;
  String? message;
  List<AnnounceData>? announce;

  AnnounceModel({this.success, this.message, this.announce});

  AnnounceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      announce = <AnnounceData>[];
      json['data'].forEach((v) {
        announce!.add(AnnounceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (announce != null) {
      data['data'] = announce!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnnounceData {
  int? id;
  int? userid;
  String? title;
  String? content;

  AnnounceData({this.id, this.userid, this.title, this.content});

  AnnounceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}