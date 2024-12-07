class Chatautodto {
  int? storeId;
  String? question;

  Chatautodto({
    required this.storeId,
    required this.question,
  });
  
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["storeId"] = storeId;
    data["question"] = question;
    return data;
  }
}