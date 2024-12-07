import 'dart:io';

class CommentDto {
  int? rate;
  String? comment;
  List<int>? productId;
  List<int>? comboId;
  List<File>? imageFiles; 

  CommentDto({this.rate, this.comment, this.productId,this.comboId,this.imageFiles});

 Map<String, String> toJson() {
    return {
      'rate': rate.toString(),
      'comment': comment ?? '',
      'productId': productId?.join(',') ?? '',
      'comboId': comboId?.join(',') ?? '',
    };
 }
}