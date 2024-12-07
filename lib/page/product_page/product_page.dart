import 'dart:convert';

import 'package:android_project/blocs/QuantityBlocs.dart';
import 'package:android_project/blocs/SizeBlocs.dart';
import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Size_controller.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Model/RateModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/page/product_page/product_rate.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  final int productId;
  const ProductPage({super.key, required this.productId});
  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  ProductController productController = Get.find<ProductController>();
  AuthController authController = Get.find<AuthController>();
  SizeController sizeController = Get.find<SizeController>();
  FunctionMap functionMap = FunctionMap();
  String selectSizeString = "M";
  bool showDescription = true;
  bool? isLoadPoint = false;
  int selectSize = 1;
  int productid = 0;
  int quantity = 1;
  int idStore = 0;
  Productitem? productitem;
  Point? currentPoint;

  QuantityBloc quantityBloc = QuantityBloc();
  Sizeblocs sizeblocs = Sizeblocs();

  @override
  void initState() {
    super.initState();
    loadData();
    getCurrentPosition();
  }

  void loadData() {
    productid = widget.productId;
    productitem = productController.getProductById(widget.productId);
    productController.getComment(widget.productId);
    productController
        .getProductByCategoryId(productitem!.category!.categoryId!);
  }

  Future<void> getCurrentPosition() async {
    currentPoint = await functionMap.getCurrentLocation();
    setState(() {
      isLoadPoint = true;
    });
  }

  void _toggleContent(bool isDescription) {
    setState(() {
      showDescription = isDescription;
    });
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  void _order(int productId) {
    quantity = quantityBloc.getQuantity();
    selectSize = sizeblocs.getSize();
    Get.toNamed(AppRoute.order_product(productId, selectSizeString, quantity));
  }

  void addTocart() async {
    quantity = quantityBloc.getQuantity();
    await sizeController.getById(selectSize);
    String sizeName = sizeController.sizeName;
    productController.addToCart(productid, quantity, idStore, sizeName);
  }

  void _showImage(item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size100 * 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimention.size20),
                image: DecorationImage(
                    image: MemoryImage(base64Decode(item)), fit: BoxFit.cover)),
          ));
        });
  }

  void _showDropdown(List<StoresItem> items, Function(String) onItemSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.grey.withOpacity(0.2),
          height: 400,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onItemSelected(items[index].storeName!);
                  Navigator.pop(context);
                },
                child: Container(
                    width: AppDimention.screenWidth,
                    padding: EdgeInsets.only(
                        left: AppDimention.size10,
                        right: AppDimention.size10,
                        top: AppDimention.size20,
                        bottom: AppDimention.size20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: AppDimention.size10),
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.store,
                                    color: AppColor.mainColor,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.6,
                                    child: Text(
                                      items[index].storeName!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppColor.mainColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.blue),
                                  Text(
                                    "${(functionMap.calculateDistance(items[index].latitude!, items[index].longitude!, isLoadPoint! ? currentPoint!.latitude! : 0, isLoadPoint! ? currentPoint!.longtitude! : 0) / 1000).toInt()}km",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppDimention.size5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColor.mainColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              Text(
                                items[index].numberPhone!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.mainColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.timelapse_rounded,
                                color: AppColor.mainColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              Text(
                                "${"${functionMap.formatTime(items[index].openingTime!)} AM - ${functionMap.formatTime(items[index].closingTime!)}"} PM",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.mainColor),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.store,
                                color: AppColor.mainColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              SizedBox(
                                width: AppDimention.screenWidth * 0.8,
                                child: Text(
                                  items[index].location!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.mainColor),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: AppDimention.size30,
                    height: AppDimention.size30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios_new, size: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Obx(() {
                    if (!authController.isLogin.value) {
                      return Container();
                    } else {
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.CART_PAGE);
                                },
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: AppDimention.size30,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              width: 20,
                              height: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: AppColor.mainColor,
                                ),
                                child: SizedBox(
                                    width: AppDimention.size10,
                                    height: AppDimention.size10,
                                    child: Center(
                                      child: Text(
                                        Get.find<CartController>()
                                            .cartList
                                            .length
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 243, 134, 134),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(AppDimention.size20),
              child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.all(AppDimention.size10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimention.size20),
                      topRight: Radius.circular(AppDimention.size20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        productitem!.productName!,
                        style: TextStyle(
                            fontSize: AppDimention.size30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("( ${productitem!.category!.categoryName!} )")
                    ],
                  )),
            ),
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.memory(
                base64Decode(productitem!.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppDimention.size20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: AppDimention.size20,
                          right: AppDimention.size20),
                      child: StreamBuilder(
                          stream: sizeblocs.sizeStream,
                          builder: (context, snapshot) {
                            int sizeId = 1;
                            if (snapshot.hasData) {
                              sizeId = snapshot.data!;
                            }
                            return Row(
                              children: [
                                Text(
                                  "đ${productitem!.discountedPrice!.toInt() != 0 ? _formatNumber(productitem!.discountedPrice!.toInt() + ((sizeId - 1) * 10000)) : _formatNumber(productitem!.price!.toInt() + ((sizeId - 1) * 10000))}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: AppDimention.size10,
                                ),
                                Text(
                                  "đ${productitem!.discountedPrice!.toInt() == 0 ? "" : _formatNumber(productitem!.price!.toInt() + ((sizeId - 1) * 10000))}",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10,
                                      color: Colors.red),
                                )
                              ],
                            );
                          }),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size20,
                            right: AppDimention.size20),
                        child: Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                  5,
                                  (index) => Icon(Icons.star,
                                      color: AppColor.mainColor,
                                      size: AppDimention.size10)),
                            ),
                            const Text(
                              "( 5 )",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.mainColor),
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: AppDimention.size20, right: AppDimention.size20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: sizeController.sizeList.map((item) {
                            return StreamBuilder(
                                stream: sizeblocs.sizeStream,
                                initialData: 1,
                                builder: (context, snapshot) {
                                  int sizeId = snapshot.data!;
                                  return GestureDetector(
                                    onTap: () {
                                      sizeblocs.setSize(item.id!);
                                      selectSizeString = item.name!;
                                    },
                                    child: Container(
                                      width: AppDimention.size30,
                                      height: AppDimention.size30,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: item.id == sizeId
                                            ? Colors.greenAccent
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text("${item.name}"),
                                      ),
                                    ),
                                  );
                                });
                          }).toList(),
                        ),
                        Text(
                          "SL : ${productitem!.stockQuantity.toString()}",
                        )
                      ],
                    )),
                SizedBox(
                  height: AppDimention.size20,
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.only(
                      left: AppDimention.size20, right: AppDimention.size20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Chi tiết sản phẩm",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: AppDimention.size10,
                      ),
                      Text(
                        productitem!.description!,
                        style: const TextStyle(color: Colors.black45),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _toggleContent(true),
                      child: Container(
                          width: AppDimention.screenWidth / 2,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: showDescription
                                          ? AppColor.mainColor
                                          : Colors.white))),
                          child: Center(
                            child: Text(
                              "Sản phẩm ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: showDescription
                                    ? AppColor.mainColor
                                    : Colors.black,
                              ),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () => _toggleContent(false),
                      child: Container(
                          width: AppDimention.screenWidth / 2,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: !showDescription
                                          ? AppColor.mainColor
                                          : Colors.white))),
                          child: Center(
                            child: Text(
                              "Đánh giá",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: !showDescription
                                    ? AppColor.mainColor
                                    : Colors.black,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                    width: AppDimention.screenWidth,
                    child: showDescription
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: 8, top: AppDimention.size10),
                                width: AppDimention.screenWidth,
                                padding:
                                    EdgeInsets.only(left: AppDimention.size10),
                                child: const Text(
                                  "Có thể bạn sẽ thích",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black38),
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
                                  itemCount: productController
                                              .productListByCategory.length >
                                          10
                                      ? 10
                                      : productController
                                          .productListByCategory.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRoute.get_product_detail(
                                                  productController
                                                      .productList[index]
                                                      .productId!));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1,
                                                color: const Color.fromRGBO(
                                                    218, 218, 218, 0.494)),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 170,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: MemoryImage(
                                                        base64Decode(
                                                            productController
                                                                .productList[
                                                                    index]
                                                                .image!)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 170,
                                                padding: EdgeInsets.only(
                                                    left: AppDimention.size10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          AppDimention.size5,
                                                    ),
                                                    Text(
                                                      productController
                                                          .productList[index]
                                                          .productName!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .mainColor),
                                                    ),
                                                    Text(
                                                      "đ${_formatNumber(productController.productList[index].price!.toInt())}",
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Wrap(
                                                              children: List.generate(
                                                                  5,
                                                                  (index) => const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: AppColor
                                                                          .mainColor,
                                                                      size: 8)),
                                                            ),
                                                            const Text(
                                                              "(5)",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: AppColor
                                                                      .mainColor),
                                                            ),
                                                          ],
                                                        ),
                                                        const Row(
                                                          children: [
                                                            Text(
                                                              "1028",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chat_bubble_outline_rounded,
                                                              size: 12,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: AppDimention
                                                            .size15),
                                                    const Row(
                                                      children: [
                                                        Icon(Icons
                                                            .delivery_dining_sharp),
                                                        Text(
                                                          "Miễn phí vận chuyển",
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                                  })
                            ],
                          )
                        : GetBuilder<ProductController>(builder: (controller) {
                            return controller.loadingComment!
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black26,
                                    ),
                                  )
                                : controller.listComment.isEmpty
                                    ? SizedBox(
                                        width: AppDimention.screenWidth,
                                        height: AppDimention.size50,
                                        child: const Center(
                                          child:
                                              Text("Sản phẩm chưa có đánh giá"),
                                        ),
                                      )
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.listComment.length,
                                        itemBuilder: (context, index) {
                                          User user = controller
                                              .listComment[index].user!;
                                          RateData item = controller
                                              .listComment[index].rateData!;
                                          return Container(
                                            width: AppDimention.screenWidth,
                                            padding: EdgeInsets.all(
                                                AppDimention.size20),
                                            margin: EdgeInsets.only(
                                                left: AppDimention.size10,
                                                right: AppDimention.size10,
                                                bottom: AppDimention.size10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size10)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("${user.fullName}"),
                                                    Row(
                                                      children: [
                                                        Wrap(
                                                          children: List.generate(
                                                              item.rate!,
                                                              (index) => Icon(
                                                                  Icons.star,
                                                                  color: AppColor
                                                                      .mainColor,
                                                                  size: AppDimention
                                                                      .size15)),
                                                        ),
                                                        SizedBox(
                                                          width: AppDimention
                                                              .size5,
                                                        ),
                                                        Text(
                                                          "(${item.rate})",
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColor
                                                                  .mainColor),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: AppDimention.size10,
                                                ),
                                                if (item
                                                    .imageRatings!.isNotEmpty)
                                                  Wrap(
                                                    spacing:
                                                        AppDimention.size10,
                                                    runSpacing:
                                                        AppDimention.size5,
                                                    children: item.imageRatings!
                                                        .map(
                                                            (item) =>
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    _showImage(
                                                                        item);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: AppDimention
                                                                        .size70,
                                                                    height: AppDimention
                                                                        .size70,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              AppDimention.size10),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black12),
                                                                      image:
                                                                          DecorationImage(
                                                                        image: MemoryImage(
                                                                            base64Decode(item)),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))
                                                        .toList(),
                                                  ),
                                                SizedBox(
                                                  height: AppDimention.size10,
                                                ),
                                                Container(
                                                    width: AppDimention
                                                        .screenWidth,
                                                    color: Colors.white,
                                                    padding: EdgeInsets.all(
                                                        AppDimention.size10),
                                                    child: Text(
                                                        "${item.comment}",
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style:
                                                            const TextStyle()))
                                              ],
                                            ),
                                          );
                                        });
                          })),
                GestureDetector(
                  onTap: () {
                    Get.to(const ProductRate());
                  },
                  child: const Center(
                    child: Text("Xem thêm"),
                  ),
                ),
                SizedBox(
                  height: AppDimention.size10,
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: AppDimention.size10,
                bottom: AppDimention.size10,
                left: AppDimention.size10,
                right: AppDimention.size10),
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimention.size10),
                topRight: Radius.circular(AppDimention.size10),
              ),
            ),
            child: Obx(() {
              if (!authController.isLogin.value) {
                return SizedBox(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size30,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.LOGIN_PAGE);
                    },
                    child: const Center(
                      child: Text(
                        "Vui lòng đăng nhập",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: AppDimention.size100,
                        padding: EdgeInsets.all(AppDimention.size5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                quantityBloc.decrement();
                              },
                              child: const Icon(
                                Icons.remove_circle_outline_rounded,
                                color: AppColor.mainColor,
                              ),
                            ),
                            StreamBuilder<int>(
                              stream: quantityBloc.quantityStream,
                              initialData: 1,
                              builder: (context, snapshot) {
                                final quantity = snapshot.data ?? 1;
                                return Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppColor.mainColor,
                                  ),
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                quantityBloc.increment();
                              },
                              child: const Icon(
                                Icons.add_circle_outline_sharp,
                                color: AppColor.mainColor,
                              ),
                            ),
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        _order(productitem!.productId!);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: AppDimention.size20,
                            bottom: AppDimention.size20,
                            left: AppDimention.size60,
                            right: AppDimention.size60),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimention.size10),
                          color: Colors.white,
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Mua ngay",
                              style: TextStyle(
                                color: AppColor.mainColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showDropdown(
                        productitem!.stores!,
                        (selectedStoreName) {
                          setState(() {
                            idStore = (productitem!.stores as List<StoresItem>)
                                .firstWhere((store) =>
                                    store.storeName == selectedStoreName)
                                .storeId!;
                            addTocart();
                          });
                        },
                      ),
                      child: Container(
                        padding: EdgeInsets.all(AppDimention.size10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimention.size10),
                          color: Colors.white,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColor.mainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
