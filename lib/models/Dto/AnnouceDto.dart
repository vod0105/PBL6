class AnnoUceDto {
  int userid;
  String title;
  String content;
  AnnoUceDto(
      {required this.userid,
      required this.title,
      required this.content});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["userid"] = userid;
    data["title"] = title;
    data["content"] = content;
    return data;
  }
}
