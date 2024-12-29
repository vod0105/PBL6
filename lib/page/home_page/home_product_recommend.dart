import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/card/product_card.dart';

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
          : productController.listProductRecommend.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 30),
                      child: Row(
                        children: [
                          SizedBox(
                            width: AppDimention.size10,
                          ),
                          Text(
                            "Sản phẩm ưu thích của bạn",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount:
                          productController.listProductRecommend.length > 10
                              ? 10
                              : productController.listProductRecommend.length,
                      itemBuilder: (context, index) {
                        Productitem item =
                            productController.listProductRecommend[index];

                        return ProductCard(
                          image: item.image!,
                          avgRate: 5.0,
                          productName: item.productName!,
                          productPrice:
                              "đ${_formatNumber(item.price!.toInt())}",
                          stockQuantity: 100,
                          isFreeFee: true,
                          onTap: () {
                            Get.toNamed(
                                AppRoute.get_product_detail(item.productId!));
                          },
                        );
                      },
                    )
                  ],
                );
    });
  }
}
