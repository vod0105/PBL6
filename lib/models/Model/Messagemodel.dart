class MessageModel {
  List<UserMessage>? listMessage;
  int? eC;
  String? eM;

  MessageModel({this.listMessage, this.eC, this.eM});

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['DT'] != null) {
      listMessage = <UserMessage>[];
      json['DT'].forEach((v) {
        listMessage!.add(UserMessage.fromJson(v));
      });
    }
    eC = json['EC'];
    eM = json['EM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listMessage != null) {
      data['DT'] = listMessage!.map((v) => v.toJson()).toList();
    }
    data['EC'] = eC;
    data['EM'] = eM;
    return data;
  }
}

class UserMessage {
  String? message;
  String? image;
  int? sender;
  int? receiver;
  String? localTime;
  String? type;

  UserMessage({this.message, this.image, this.sender, this.receiver, this.localTime});

  UserMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    image = json['image'];
    sender = json['sender'];
    receiver = json['receiver'];
    localTime = json['local_time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['image'] = image;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['local_time'] = localTime;
    data['type'] = type;
    return data;
  }
}