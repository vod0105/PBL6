import 'dart:convert';

import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductController>().search();
  }

  @override
  Widget build(BuildContext context) {
    List<String> listrecommend = ["Classic Burger", "Pepsi", "Trà chanh"];
    return GetBuilder<ProductController>(builder: (productController) {
      return Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            padding: EdgeInsets.only(
                top: AppDimention.size10, bottom: AppDimention.size10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listrecommend.map((item) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        productController.updateTextSearch(item);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item,
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.clear,
                              size: 13,
                            ),
                          )
                        ],
                      ),
                    ));
              }).toList(),
            ),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: productController.productListSearch.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.get_product_detail(
                        productController.productList[index].productId));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 1,
                          color: Color.fromRGBO(218, 218, 218, 0.494)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 170,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(base64Decode(productController
                                  .productListSearch[index].image!)),
                            ),
                          ),
                        ),
                        Container(
                          width: 170,
                          padding: EdgeInsets.only(left: AppDimention.size10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: AppDimention.size5,
                              ),
                              Text(
                                productController
                                    .productList[index].productName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.mainColor),
                              ),
                              Text(
                                "${productController.productList[index].price} vnđ",
                                style: TextStyle(fontSize: 13),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Wrap(
                                        children: List.generate(
                                            5,
                                            (index) => Icon(Icons.star,
                                                color: AppColor.mainColor,
                                                size: 8)),
                                      ),
                                      Text(
                                        "(5)",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.mainColor),
                                      ),
                                    ],
                                  ),
                                  Row(
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
                                  Icon(Icons.delivery_dining_sharp),
                                  Text(
                                    "Miễn phí vận chuyển",
                                    style: TextStyle(fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            },
          )
        ],
      );
    });
  }
}
