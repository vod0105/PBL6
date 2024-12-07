class PromotionDto {
  int? promotionId;
  int? storeId;
  PromotionDto({
    this.promotionId,
    this.storeId,
  });
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["promotionId"] = promotionId;
    data["storeId"] = storeId;
    return data;
  }
}