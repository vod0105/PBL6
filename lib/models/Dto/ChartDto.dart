class ChartDto {
  int? sender;
  int? receiver;
  String? message;
  String? imageBase64;
  bool? isRead;

  ChartDto({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.imageBase64,
    required this.isRead
  });
  
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["sender"] = sender;
    data["receiver"] = receiver;
    data["message"] = message;
    data["imageBase64"] = imageBase64;
    data["isRead"] = isRead;
    return data;
  }
}