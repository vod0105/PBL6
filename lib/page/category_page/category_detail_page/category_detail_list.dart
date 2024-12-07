import 'dart:convert';

import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailList extends StatefulWidget {
  final int categoryId;
  const CategoryDetailList({super.key, required this.categoryId});

  @override
  CategoryDetailListState createState() => CategoryDetailListState();
}

class CategoryDetailListState extends State<CategoryDetailList> {
  late ProductController productController;
  @override
  void initState() {
    super.initState();
    productController = Get.find();
    productController.getProductByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: productController.productListByCategory.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: Container(
                width: AppDimention.size170 + 2 * AppDimention.size100,
                height: AppDimention.size150 + AppDimention.size10,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: const Color.fromRGBO(0, 0, 0, 0.1)),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.get_product_detail(productController
                        .productListByCategory[index].productId!));
                  },
                  child: Row(
                    children: [
                      Container(
                        width: AppDimention.size150,
                        height: AppDimention.size150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(base64Decode(productController
                                  .productListByCategory[index].image!)),
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: AppDimention.size10),
                          height: AppDimention.size150,
                          child: Padding(
                            padding: EdgeInsets.only(left: AppDimention.size10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productController
                                      .productListByCategory[index]
                                      .productName!,
                                  style: TextStyle(
                                      fontSize: AppDimention.size25,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: AppDimention.size5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text("4.5"),
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: AppDimention.size30,
                                    ),
                                    Text(
                                      "Giá : ${productController.productListByCategory[index].price.toString()} vnđ",
                                      style: TextStyle(
                                        fontSize: AppDimention.size10,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppDimention.size5,
                                ),
                                SizedBox(
                                  height: AppDimention.size5,
                                ),
                                Container(
                                  width: AppDimention.size150,
                                  height: AppDimention.size40,
                                  decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text(
                                      "Mua ngay",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      );
    });
  }
}
