import 'dart:convert';

import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Size_controller.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Model/StoreModel.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  final int productId;

  ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductController productController;
  int quantity = 1;
  int productid = 0;
  int idstore = 0;
  bool showDescription = true;
  int selectSize = 1;

  @override
  void initState() {
    super.initState();
    productController = Get.find();
    productid = widget.productId;
    productController.getProductById(widget.productId);
  }

  void _toggleContent(bool isDescription) {
    setState(() {
      showDescription = isDescription;
    });
  }

  void _showDropdown(List<String> items, Function(String) onItemSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  onItemSelected(items[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void addtocart() async {
    await Get.find<SizeController>().getbyidl(selectSize);
    String sizename = Get.find<SizeController>().sizename;
    Get.find<ProductController>()
        .addtocart(productid, quantity, idstore, sizename);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      if (productController.productListDetail.isEmpty) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()),
        );
      }
      var product = productController.productListDetail[0];
      if (productController.productListBycategory.isEmpty) {
        productController.getProductByCategoryId(product.category.categoryId);
      }
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
                        borderRadius:
                            BorderRadius.circular(AppDimention.size30),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back_ios_new, size: 15),
                      ),
                    ),
                  ),
                  Container(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(color: Colors.white, width: 2),
                              color: AppColor.mainColor,
                            ),
                            child: Container(
                                width: AppDimention.size10,
                                height: AppDimention.size10,
                                child: Center(
                                  child: Text(
                                    Get.find<CartController>()
                                        .cartlist
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              pinned: true,
              backgroundColor: const Color.fromARGB(255, 243, 134, 134),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(AppDimention.size20),
                child: Container(
                  child: Center(
                      child: Text(
                    product.productName!,
                    style: TextStyle(
                        fontSize: AppDimention.size30,
                        fontWeight: FontWeight.bold),
                  )),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                      top: AppDimention.size10, bottom: AppDimention.size10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimention.size20),
                      topRight: Radius.circular(AppDimention.size20),
                    ),
                  ),
                ),
              ),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.memory(
                  base64Decode(product.image!),
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
                        child: Text(
                          product.price.toString() + " vnđ ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
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
                                        size: AppDimention.size15)),
                              ),
                              Text(
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
                    child: Text(
                      "Giá khuyến mãi : " +
                          product.discountedPrice.toString() +
                          " vnđ",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: AppDimention.size20, right: AppDimention.size20),
                    child: Text(
                      "Số lượng còn lại : " + product.stockQuantity.toString(),
                    ),
                  ),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  GetBuilder<SizeController>(builder: (sizecontroller) {
                    return Row(
                      children: sizecontroller.sizelist.map((item) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectSize = item.id!;
                            });
                          },
                          child: Container(
                            width: AppDimention.size30,
                            height: AppDimention.size30,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: item.id == selectSize
                                  ? const Color.fromARGB(255, 114, 255, 118)
                                  : Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                            child: Center(
                              child: Text(item.name!),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: AppDimention.screenWidth,
                height: 300,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black26),
                    bottom: BorderSide(width: 1, color: Colors.black26),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 300,
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          size: 60,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 30),
                        height: 300,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: product.stores.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                height: AppDimention.size120,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black26),
                                    left: BorderSide(
                                        width: 1, color: Colors.black26),
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cửa hàng số " +
                                          product.stores[index].storeId
                                              .toString() +
                                          " : " +
                                          product.stores[index].storeName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Địa chỉ : " +
                                          product.stores[index].location,
                                      style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _toggleContent(true),
                        child: Container(
                            child: Container(
                                width: AppDimention.screenWidth / 2,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: showDescription
                                        ? AppColor.mainColor
                                        : Colors.white),
                                child: Center(
                                  child: Text(
                                    "Mô tả",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: showDescription
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ))),
                      ),
                      GestureDetector(
                        onTap: () => _toggleContent(false),
                        child: Container(
                            width: AppDimention.screenWidth / 2,
                            height: 50,
                            decoration: BoxDecoration(
                                color: !showDescription
                                    ? AppColor.mainColor
                                    : Colors.white),
                            child: Center(
                              child: Text(
                                "Đánh giá",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: !showDescription
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    width: AppDimention.screenWidth,
                    child: showDescription
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text("Mô tả : " + product.description),
                              SizedBox(height: 10),
                              Text("Danh mục  : " +
                                  product.category.categoryName),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                width: AppDimention.screenWidth,
                                height: 60,
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                child: Center(
                                  child: Text(
                                    "Có thể bạn sẽ thích",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue),
                                  ),
                                ),
                              ),
                              GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: productController
                                              .productListBycategory.length >
                                          10
                                      ? 10
                                      : productController
                                          .productListBycategory.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              AppRoute.get_product_detail(
                                                  productController
                                                      .productList[index]
                                                      .productId));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1,
                                                color: Color.fromRGBO(
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
                                                          .productName,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .mainColor),
                                                    ),
                                                    Text(
                                                      "${productController.productList[index].price} vnđ",
                                                      style: TextStyle(
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
                                                                  (index) => Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: AppColor
                                                                          .mainColor,
                                                                      size: 8)),
                                                            ),
                                                            Text(
                                                              "(5)",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: AppColor
                                                                      .mainColor),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
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
                                                    Row(
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
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                width: AppDimention.screenWidth,
                                height: 160,
                                margin: EdgeInsets.only(top: 25),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 160,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "https://wallpaperaccess.com/full/6790132.png")),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Nguyễn Văn Nhật")
                                          ],
                                        )),
                                    Container(
                                      width: AppDimention.screenWidth - 100,
                                      height: AppDimention.size150 +
                                          AppDimention.size20,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  width: 1,
                                                  color: Colors.black26))),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bánh sandwich loại lớn lớn",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Tổng giá : \$100"),
                                          Row(
                                            children: [
                                              Wrap(
                                                children: List.generate(
                                                    5,
                                                    (index) => Icon(Icons.star,
                                                        color:
                                                            AppColor.mainColor,
                                                        size: AppDimention
                                                            .size15)),
                                              ),
                                              Text(
                                                "( 5 )",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.mainColor),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Bình luận : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width:
                                                AppDimention.screenWidth - 160,
                                            height: 62,
                                            child: Text(
                                              "Bánh này dở nha mn , giá thì đắt lòi mà nhân thì không có cái vẹo gì , lần sau đách mua nữa lần sau đách mua nữa lần sau đách mua nữa lần sau đách mua nữa ",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
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
                  left: AppDimention.size20 * 2.5,
                  right: AppDimention.size20 * 2.5,
                  top: AppDimention.size10,
                  bottom: AppDimention.size10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity < 20) quantity++;
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: AppDimention.size20,
                  bottom: AppDimention.size20,
                  left: AppDimention.size20,
                  right: AppDimention.size20),
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimention.size20 * 2),
                  topRight: Radius.circular(AppDimention.size20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: AppDimention.size20,
                        bottom: AppDimention.size20,
                        left: AppDimention.size20,
                        right: AppDimention.size20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimention.size20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: AppColor.mainColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: AppDimention.size20,
                        bottom: AppDimention.size20,
                        left: AppDimention.size50,
                        right: AppDimention.size50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimention.size20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [Text("Mua ngay")],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showDropdown(
                      (product.stores as List<Storesitem>)
                          .map<String>((store) => store.storeName ?? '')
                          .toList(),
                      (selectedStoreName) {
                        setState(() {
                          idstore = (product.stores as List<Storesitem>)
                              .firstWhere((store) =>
                                  store.storeName == selectedStoreName)
                              .storeId!;
                          addtocart();
                        });
                      },
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: AppDimention.size20,
                          bottom: AppDimention.size20,
                          left: AppDimention.size20,
                          right: AppDimention.size20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppDimention.size20),
                        color: Colors.white,
                      ),
                      child: Row(
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
              ),
            ),
          ],
        ),
      );
    });
  }
}
