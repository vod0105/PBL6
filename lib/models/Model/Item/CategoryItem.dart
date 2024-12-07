class CategoryItem {
  int? categoryId;
  String? categoryName;
  String? description;
  String? image;

  CategoryItem(
      {this.categoryId, this.categoryName, this.description, this.image});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
