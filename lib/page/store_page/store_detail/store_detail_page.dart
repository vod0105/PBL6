import 'dart:convert';

import 'package:android_project/data/controller/Category_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Promotion_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';

import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Model/PromotionModel.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StoreDetailPage extends StatefulWidget {
  final int storeId;
  const StoreDetailPage({
    required this.storeId,
    super.key,
  });
  @override
  StoreDetailPageState createState() => StoreDetailPageState();
}

class StoreDetailPageState extends State<StoreDetailPage> {
  PromotionController promotionController = Get.find<PromotionController>();
  CategoryController categoryController = Get.find<CategoryController>();
  Storecontroller storecontroller = Get.find<Storecontroller>();
  ProductController productController = Get.find<ProductController>();
  List<PromotionData> listPromotion = [];
  bool _isLoad = true;
  int? categorySelected;
  StoresItem? storesItem;
  String? title;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadData();
    _loadInFoMaTiOn();
  }

  Future<void> _loadData() async {
    await promotionController.getByStoreId(widget.storeId);
    await categoryController.getByStoreId(widget.storeId);
    await storecontroller.getById(widget.storeId);
    setState(() {
      listPromotion = promotionController.listPromotionByStoreId;
      _isLoad = false;
    });
  }

  void _loadProduct(int storeid, int categoryId) async {
    await productController.getProductByStoreCategoryId(storeid, categoryId);
  }

  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('hh:mm').format(dateTime);
  }

  void _loadInFoMaTiOn() {
    if (!_isLoad) {
      categorySelected = categoryController.categoryListStoreId[0].categoryId;
      title = categoryController.categoryListStoreId[0].categoryName;
      storesItem = storecontroller.storeItem!;

      _loadProduct(storesItem!.storeId!,
          categoryController.categoryListStoreId[0].categoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Storecontroller>(builder: (controller) {
      return _isLoad
          ? Container(
              width: AppDimention.screenWidth,
              height: AppDimention.screenHeight,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "Loading ...",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.size100 * 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(base64Decode(storesItem!.image!)),
                    )),
                    child: Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size100 * 2,
                        padding: EdgeInsets.all(AppDimention.size20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: AppDimention.size40,
                                    height: AppDimention.size40,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            132, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(
                                            AppDimention.size30)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.CART_PAGE);
                                  },
                                  child: Container(
                                    width: AppDimention.size40,
                                    height: AppDimention.size40,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            132, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(
                                            AppDimention.size30)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: AppDimention.size100 * 2,
                  child: SizedBox(
                      width: AppDimention.screenWidth,
                 
                      
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppDimention.size80,
                            ),
                            Text(
                              storesItem!.storeName.toString(),
                              style: TextStyle(
                                  fontSize: AppDimention.size20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: AppDimention.screenWidth,
                              padding: EdgeInsets.only(
                                  left: AppDimention.size10,
                                  right: AppDimention.size10),
                              child: Center(
                                child: Text(
                                  "Địa chỉ :${storesItem!.location} ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.black38),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppDimention.size10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: AppDimention.size130,
                                  height: AppDimention.size60,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(
                                        width: 1, color: Colors.black26),
                                  )),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            "4.1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "50+ đánh giá",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: AppDimention.size130,
                                  height: AppDimention.size60,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    right: BorderSide(
                                        width: 1, color: Colors.black26),
                                  )),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.timelapse_sharp,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            "10-20 phút",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Dự kiến giao",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: AppDimention.size120,
                                  height: AppDimention.size60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.av_timer,
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${formatTime(storesItem!.openingTime!)} - ${formatTime(
                                                storesItem!.closingTime!)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            if (listPromotion.isNotEmpty)
                              Column(
                                children: [
                                  
                                  Container(
                                    width: AppDimention.screenWidth,
                                    height: AppDimention.size60,
                                    decoration: BoxDecoration(
                                      
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.grey[200]!),
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.grey[200]!))),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.only(right: AppDimention.size10),
                                      child: Row(
                                        children: listPromotion
                                            .map((item) => Container(
                                                  width: AppDimention.size100 *
                                                      2.5,
                                                  height: AppDimention.size40,
                                                  padding: EdgeInsets.only(
                                                      left: AppDimention.size10,
                                                      right:
                                                          AppDimention.size10),
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          AppDimention.size10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(AppDimention.size5),
                                                      image: DecorationImage(image: promotionController.checkVoucher(item.code!) ? const AssetImage("assets/image/Voucher0.png") :const AssetImage("assets/image/Voucher2.png") ,fit: BoxFit.cover)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${item.discountPercent!.toInt()}%"),
                                                          SizedBox(
                                                            width: AppDimention
                                                                .size10,
                                                          ),
                                                          Text("${item.code}")
                                                        ],
                                                      ),
                                                      if(promotionController.checkVoucher(item.code!))
                                                        GestureDetector(
                                                          onTap: () {
                                                            promotionController.savePromotion(item.voucherId!);
                                                          },
                                                          child: const Text("Lưu"),
                                                        ),
                                                      if(!promotionController.checkVoucher(item.code!))
                                                      GestureDetector(
                                                          onTap: () {},
                                                          child: const Text("Đã có"),
                                                        )

                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                           
                            Container(
                              width: AppDimention.screenWidth,
                              height: AppDimention.size60,
                              padding:
                                  EdgeInsets.only(right: AppDimention.size10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black12),
                                      top: BorderSide(
                                          width: 1, color: Colors.black12))),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: categoryController
                                      .categoryListStoreId
                                      .map((item) => Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    categorySelected =
                                                        item.categoryId;
                                                    title = item.categoryName;
                                                  });

                                                  _loadProduct(
                                                      storesItem!.storeId!,
                                                      categorySelected!);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          AppDimention.size10),
                                                  padding: EdgeInsets.only(
                                                      left: AppDimention.size20,
                                                      right:
                                                          AppDimention.size20),
                                                  height: AppDimention.size50,
                                                  decoration: BoxDecoration(
                                                      color: item.categoryId ==
                                                              categorySelected
                                                          ? Colors.amber
                                                          : Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size5)),
                                                  child: Center(
                                                    child: Text(
                                                      item.categoryName!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            Container(
                              width: AppDimention.screenWidth,
                              padding: EdgeInsets.only(
                                  left: AppDimention.size10,
                                  right: AppDimention.size10),
                              child: Text(
                                title!,
                                style: TextStyle(
                                    fontSize: AppDimention.size25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                            ),
                            SizedBox(
                              height: AppDimention.size20,
                            ),
                            GetBuilder<ProductController>(
                                builder: (productController) {
                              return productController.isLoadingStoreCategory
                                  ? const CircularProgressIndicator()
                                  : Column(
                                      children: Get.find<ProductController>()
                                          .productListByCategoryStore
                                          .map((item) => Container(
                                                width: AppDimention.screenWidth,
                                                height: AppDimention.size130,
                                                padding: EdgeInsets.only(
                                                    top: AppDimention.size10,
                                                    bottom:
                                                        AppDimention.size10),
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        AppDimention.size10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100]),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: AppDimention
                                                              .size10,
                                                          right: AppDimention
                                                              .size10),
                                                      width:
                                                          AppDimention.size100,
                                                      height:
                                                          AppDimention.size100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimention
                                                                      .size10),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: MemoryImage(
                                                                  base64Decode(item
                                                                      .image!)))),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(item.productName!,
                                                            style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                        Row(
                                                          children: [
                                                            Wrap(
                                                              children:
                                                                  List.generate(
                                                                      5,
                                                                      (index) {
                                                                if (index <
                                                                    item.averageRate!
                                                                        .floor()) {
                                                                  return Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
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
                                                                      color: Colors
                                                                          .amber,
                                                                      size: AppDimention
                                                                          .size15);
                                                                } else {
                                                                  return Icon(
                                                                      Icons
                                                                          .star_border,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: AppDimention
                                                                          .size15);
                                                                }
                                                              }),
                                                            ),
                                                            Text(
                                                              "(${item.averageRate})",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .amber,
                                                                  fontSize: 12),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              item.discountedPrice !=
                                                                      0
                                                                  ? "đ${item.discountedPrice!.toInt()}"
                                                                  : "đ${item.price!.toInt()}",
                                                              style: const TextStyle(
                                                                  color: AppColor
                                                                      .mainColor),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  AppDimention
                                                                      .size5,
                                                            ),
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  item.discountedPrice !=
                                                                          0
                                                                      ? "đ${item.price!.toInt()}"
                                                                      : "",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black26,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                                if (item.discountedPrice !=
                                                                    0)
                                                                  Positioned(
                                                                    child:
                                                                        Container(
                                                                      width: 60,
                                                                      height: 1,
                                                                      color: Colors
                                                                          .black26,
                                                                      transform:
                                                                          Matrix4.rotationZ(
                                                                              0),
                                                                    ),
                                                                  ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .delivery_dining_sharp,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                Text(
                                                                  "Miễn phí vận chuyển",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  AppDimention
                                                                      .size30,
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Get.toNamed(AppRoute
                                                                      .get_product_detail(
                                                                          item.productId!));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      AppDimention
                                                                          .size80,
                                                                  height: AppDimention
                                                                          .size40 -
                                                                      1,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColor
                                                                          .mainColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              AppDimention.size5)),
                                                                  child: const Center(
                                                                    child: Text(
                                                                      "Mua",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ))
                                          .toList());
                            }),
                            SizedBox(
                              height: AppDimention.size40,
                            ),
                          ],
                        ),
                      )),
                ),
                Positioned(
                    top: AppDimention.size100 * 2 -
                        AppDimention.size70 -
                        AppDimention.size5,
                    left: 0,
                    child: Column(
                      children: [
                        SizedBox(
                          width: AppDimention.screenWidth,
                          height: AppDimention.size150,
                          child: Center(
                            child: Container(
                              height: AppDimention.size150,
                              width: AppDimention.size150,
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size150),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(
                                        base64Decode(storesItem!.image!)),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ));
    });
  }
}
