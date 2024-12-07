import 'dart:convert';

import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProductRecommend extends StatefulWidget {
  const HomeProductRecommend({
    super.key,
  });

  @override
  HomeProductRecommendState createState() => HomeProductRecommendState();
}

class HomeProductRecommendState extends State<HomeProductRecommend> {
  @override
  void initState() {
    super.initState();
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      productController.getProductRecommend();
      return productController.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productController.listProductRecommend.isEmpty ? const Center(child: Text("Hiện chưa có sản phẩm gợi ý cho bạn"),)  :  Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: AppDimention.size10,
                    ),
                    Text(
                      "Sản phẩm ưu thích của bạn",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Productitem item = productController.listProductRecommend[index];
                    
                    return GestureDetector(
                      onTap: () {
                       
                        Get.toNamed(
                            AppRoute.get_product_detail(item.productId!));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(218, 218, 218, 0.494)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 170,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:item.image != null ?  MemoryImage(base64Decode(item.image!)) : const AssetImage("assets/image/LoadingBg.png"),
                                ),
                              ),
                            ),
                            Container(
                              width: 170,
                              padding:
                                  EdgeInsets.only(left: AppDimention.size10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: AppDimention.size5,
                                  ),
                                  Text(
                                    item.productName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.mainColor),
                                  ),
                                  Text(
                                    "đ${_formatNumber(item.price!.toInt())}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Wrap(
                                            children: List.generate(5, (index) {
                                              if (index <
                                                  item.averageRate!.floor()) {
                                                return Icon(Icons.star,
                                                    color: AppColor.mainColor,
                                                    size: AppDimention.size15);
                                              } else if (index ==
                                                      item.averageRate!
                                                          .floor() &&
                                                  item.averageRate! % 1 != 0) {
                                                return Icon(Icons.star_half,
                                                    color: AppColor.mainColor,
                                                    size: AppDimention.size15);
                                              } else {
                                                return Icon(Icons.star_border,
                                                    color: AppColor.mainColor,
                                                    size: AppDimention.size15);
                                              }
                                            }),
                                          ),
                                          const Text(
                                            "(5)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.mainColor),
                                          ),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            "1028",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.chat_bubble_outline_rounded,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppDimention.size15),
                                  Row(
                                    children: [
                                      const Icon(Icons.delivery_dining_sharp),
                                      Text(
                                        "Miễn phí vận chuyển",
                                        style: TextStyle(fontSize: 10,color: Colors.black.withOpacity(0.7)),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            );
    });
  }
}
