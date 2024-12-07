import 'dart:convert';
import 'package:android_project/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:android_project/data/controller/Category_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeFolder extends StatefulWidget {
  const HomeFolder({super.key});

  @override
  HomeFolderState createState() => HomeFolderState();
}

class HomeFolderState extends State<HomeFolder> {
  int? categorySelected = 0;
  final ProductController productController = Get.find<ProductController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final ScrollController _scrollController = ScrollController();

  List<IconData> listIconCategory = [
    FontAwesomeIcons.burger,
    FontAwesomeIcons.pizzaSlice,
    FontAwesomeIcons.fire,
    FontAwesomeIcons.lemon,
    FontAwesomeIcons.cheese,
    FontAwesomeIcons.drumstickBite,
    FontAwesomeIcons.cookie,
    FontAwesomeIcons.martiniGlassCitrus
  ];

  bool? loaded = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  Future<void> loadData() async {
    while (categoryController.isLoading == true) {
      await Future.delayed(const Duration(seconds: 1));
    }
    await productController
        .getProductByCategoryId(categoryController.categoryList[0].categoryId!);
    categorySelected = categoryController.categoryList[0].categoryId;
    setState(() {
      loaded = true;
    });
  }

  void _onCategorySelected(int selectedCategoryId, int index) {
    productController.getProductByCategoryId(selectedCategoryId);
    setState(() {
      categorySelected = selectedCategoryId;
    });

    _scrollController.animateTo(
      index * (AppDimention.size150 - 5 * index ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        return categoryController.isLoading!
            ? SizedBox(
                width: AppDimention.screenWidth,
                child: const Center(child: CircularProgressIndicator()),
              )
            : SizedBox(
                width: AppDimention.screenWidth,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: AppDimention.size10),
                        Text(
                          "Danh mục sản phẩm",
                          style: TextStyle(
                            
                              fontSize: 25, fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    Container(
                      width: AppDimention.screenWidth,
                      padding: EdgeInsets.only(
                          top: AppDimention.size5, bottom: AppDimention.size15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.black12)),
                      ),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: loaded == true
                              ? Row(
                                  children: List.generate(
                                      categoryController.categoryList.length,
                                      (index) {
                                    final item =
                                        categoryController.categoryList[index];
                                    return GestureDetector(
                                      onTap: () => _onCategorySelected(
                                          item.categoryId!, index),
                                      child: Container(
                                        padding: EdgeInsets.only(left: AppDimention.size20,right: AppDimention.size20),
                                        height: AppDimention.size50,
                                        margin: EdgeInsets.only(
                                            left: AppDimention.size20,
                                            top: AppDimention.size10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(AppDimention.size10),
                                          gradient: item.categoryId ==
                                                  categorySelected
                                              ? const LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.amber,
                                                    Colors.white
                                                  ],
                                                )
                                              : null,
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 2,
                                              color: item.categoryId ==
                                                      categorySelected
                                                  ? Colors.amber
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              listIconCategory[index],
                                              color: item.categoryId ==
                                                      categorySelected
                                                  ? Colors.blue
                                                  : Colors.amber,
                                              size: 15,
                                            ),
                                            SizedBox(width: AppDimention.size10,),
                                            Text(item.categoryName!,style: TextStyle(
                                              color: item.categoryId ==
                                                      categorySelected
                                                  ? Colors.blue
                                                  : Colors.amber
                                            ),)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              : SizedBox(
                                  width: AppDimention.screenWidth,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                )),
                    ),
                    SizedBox(height: AppDimention.size10),
                    if (loaded == true)
                      SizedBox(
                        width: AppDimention.screenWidth,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GetBuilder<ProductController>(
                            builder: (productController) {
                              return productController
                                      .isLoadingProductInCategory
                                  ? const CircularProgressIndicator()
                                  : Row(
                                      children: productController
                                          .productListByCategory
                                          .map((item) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                AppRoute.get_product_detail(
                                                    item.productId!));
                                          },
                                          child: Container(
                                            width: AppDimention.size100 * 2.5,
                                            height: AppDimention.size100 * 3.6,
                                            padding: EdgeInsets.all(
                                                AppDimention.size10),
                                            margin: EdgeInsets.only(
                                                left: AppDimention.size10,
                                                right: AppDimention.size15,
                                                top: AppDimention.size10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimention.size10),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      AppDimention.screenWidth,
                                                  height: AppDimention.size100 *
                                                      2.4,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimention 
                                                                .size10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:item.image != null ?  MemoryImage(base64Decode(item.image!)) : const AssetImage("assets/image/LoadingBg.png"),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        AppDimention.size20),
                                                Text(
                                                  item.productName!,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,color: Colors.black.withOpacity(0.7)),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                    height:
                                                        AppDimention.size10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Wrap(
                                                          children:
                                                              List.generate(5,
                                                                  (index) {
                                                            if (index <
                                                                item.averageRate!
                                                                    .floor()) {
                                                              return Icon(
                                                                  Icons.star,
                                                                  color: AppColor
                                                                      .mainColor,
                                                                  size: AppDimention
                                                                      .size15);
                                                            } else if (index ==
                                                                    item.averageRate!
                                                                        .floor() &&
                                                                item.averageRate! %
                                                                        1 !=
                                                                    0) {
                                                              return Icon(
                                                                  Icons
                                                                      .star_half,
                                                                  color: AppColor
                                                                      .mainColor,
                                                                  size: AppDimention
                                                                      .size15);
                                                            } else {
                                                              return Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: AppColor
                                                                      .mainColor,
                                                                  size: AppDimention
                                                                      .size15);
                                                            }
                                                          }),
                                                        ),
                                                        Text(
                                                          "(${item.averageRate})",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "đ${_formatNumber(item.price!.toInt())}",
                                                      style: const TextStyle(
                                                          color: AppColor
                                                              .mainColor,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              );
      },
    );
  }
}
