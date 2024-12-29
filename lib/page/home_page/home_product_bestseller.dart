import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/page/widget/card/product_card.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProductBestseller extends StatefulWidget {
  const HomeProductBestseller({
    super.key,
  });

  @override
  HomeProductBestsellerState createState() => HomeProductBestsellerState();
}

class HomeProductBestsellerState extends State<HomeProductBestseller> {
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
      return productController.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Transform.translate(
                  offset: const Offset(0, 30),
                  child: Row(
                    children: [
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                      Text(
                        "Sản phẩm bán chạy",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    itemCount: productController.productList.length > 10
                        ? 10
                        : productController.productList.length,
                    itemBuilder: (context, index) {
                      Productitem item = productController.productList[index];
                      return ProductCard(
                        image: item.image!,
                        avgRate: 5.0,
                        productName: item.productName!,
                        productPrice: "đ${_formatNumber(item.price!.toInt())}",
                        stockQuantity: 100,
                        isFreeFee: true,
                        onTap: () {
                          Get.toNamed(
                              AppRoute.get_product_detail(item.productId!));
                        },
                      );
                    },
                  ),
                )
              ],
            );
    });
  }
}
