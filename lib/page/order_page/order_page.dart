import 'dart:io';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/models/Dto/CommentDto.dart';
import 'package:android_project/models/Model/Item/ComboItem.dart';
import 'package:android_project/models/Model/OrderModel.dart';
import 'package:android_project/page/order_page/order_footer.dart';
import 'package:android_project/page/order_page/order_header.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
  });
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  bool isChildVisible = false;
  TextEditingController feedbackController = TextEditingController();
  ProductController productController = Get.find<ProductController>();
  OrderController orderController = Get.find<OrderController>();
  OverlayEntry? overlayEntry;

  void showPopover(BuildContext context, Offset offset, String message) {
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + 10,
        left: offset.dx - 30,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            width: AppDimention.size100,
            child: Center(
                child: Text(
              message,
              style: const TextStyle(color: Colors.grey),
            )),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry!);
    Future.delayed(const Duration(milliseconds: 500), () {
      overlayEntry?.remove();
    });
  }

  void showFeedBack(OrderItem item) {
    List<OrderDetails>? orderDetails = item.orderDetails;

    List<int> listIdProduct = [];
    List<int> listIdCombo = [];
    for (OrderDetails orderDetail in orderDetails!) {
      if (orderDetail.type == "product") {
        listIdProduct.add(orderDetail.productDetail!.productId!);
      }
      else{
        listIdCombo.add(orderDetail.comboDetail!.comboId!);
      }
    }
    List<int> listStar = [1, 2, 3, 4, 5];
    int starSelected = 5;

    List<File> selectedImages = [];
    int countImage = 6;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              Future<void> pickImage() async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    selectedImages.add(File(pickedFile.path));
                  });
                }
              }

              return Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size100 * 6,
                padding: EdgeInsets.all(AppDimention.size20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text("Đánh giá"),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: listStar
                            .map((item) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      starSelected = item;
                                    });
                                  },
                                  child: Container(
                                    width: AppDimention.size30,
                                    height: AppDimention.size30,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: starSelected == item
                                          ? Colors.greenAccent
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text("$item"),
                                    ),
                                  ),
                                ))
                            .toList()),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    SizedBox(
                      width: AppDimention.size100 * 3,
                      child: Wrap(
                        
                        spacing: AppDimention.size10,
                        runSpacing: AppDimention.size5,
                        children: [
                          ...selectedImages.map((imageFile) {
                            return Container(
                              width: AppDimention.size80,
                              height: AppDimention.size80,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size10),
                                border:
                                    Border.all(width: 1, color: Colors.black12),
                                image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          if(selectedImages.length < countImage)
                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: AppDimention.size80,
                              height: AppDimention.size80,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size10),
                                border:
                                    Border.all(width: 1, color: Colors.black12),
                                color: Colors.grey[200],
                              ),
                              child: const Icon(Icons.add_a_photo,
                                  color: Colors.black45),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: AppDimention.size100 * 3,
                      margin: EdgeInsets.only(top: AppDimention.size10),
                      height: AppDimention.size100 * 3 * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black26),
                        borderRadius:
                            BorderRadius.circular(AppDimention.size10),
                      ),
                      child: TextField(
                        controller: feedbackController,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(AppDimention.size10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        _sendFeedBack(
                            listIdProduct,listIdCombo, item.orderId!, starSelected,selectedImages);
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size10)),
                        child: const Center(
                          child: Text(
                            "Gửi",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showCancelOrder(String ordercode, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size100 * 1.6,
                padding: EdgeInsets.all(AppDimention.size20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [
                  Container(
                    width: AppDimention.screenWidth,
                    padding: EdgeInsets.all(AppDimention.size10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: Colors.black26))),
                    child: const Text("Xác nhận hủy đơn hàng"),
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: AppDimention.size120,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColor.mainColor),
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5)),
                          child: const Center(
                            child: Text("Thoát"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _cancelOrder(ordercode, status);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: AppDimention.size120,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColor.mainColor),
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5)),
                          child: const Center(
                            child: Text("Xác nhận"),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              );
            },
          ),
        );
      },
    );
  }

  void _sendFeedBack(List<int> listIdProduct,List<int> listIdCombo, int orderid, int rate,List<File> selectedImages) {
    String feedbackMessage = feedbackController.text;

    CommentDto commentDto =
          CommentDto(productId: listIdProduct,comboId: listIdCombo, comment: feedbackMessage, rate: rate,imageFiles: selectedImages);
      productController.addComment(commentDto);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const OrderPage(),
    ));
  }

  void _toggleBar() {
    if (isShowBar) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isChildVisible = true;
        });
      });
    } else {
      setState(() {
        isChildVisible = false;
      });
    }
  }

  String? selectedStatus = "All";

  AuthController? authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    if (authController!.isLogin.value) orderController.getAll();
  }

  bool isShowBar = false;

  void _cancelOrder(String ordercode, String status) {
    orderController.cancelOrder(ordercode, status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const OrderHeader(),
          Obx(() {
            if (!authController!.isLogin.value) {
              return Expanded(
               
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.LOGIN_PAGE);
                  },
                  child: const Center(
                    child: Text("Vui lòng đăng nhập"),
                  ),
                )),
              );
            } else {
              return Expanded(
                  child: Stack(children: [
                Positioned(child: SingleChildScrollView(
                  child: GetBuilder<OrderController>(
                    builder: (orderController) {
                      return !orderController.isLoading
                          ? orderController.orderList.isEmpty
                              ? Container(
                                  width: AppDimention.screenWidth,
                                  padding:
                                      EdgeInsets.only(top: AppDimention.size40),
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text("Bạn không có đơn hàng nào"),
                                        SizedBox(
                                          height: AppDimention.size10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoute.SEARCH_PAGE);
                                          },
                                          child: Container(
                                            width: AppDimention.size120,
                                            height: AppDimention.size40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColor.mainColor),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size10)),
                                            child: const Center(
                                              child: Text("Mua hàng"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: orderController.orderList.length,
                                  itemBuilder: (context, index) {
                                    var orderDetails = orderController
                                        .orderList[index].orderDetails;
                                    if (orderDetails == null ||
                                        orderDetails.isEmpty) {
                                      return Container(
                                        width: AppDimention.screenWidth,
                                        height: 200,
                                        decoration: const BoxDecoration(
                                            color: AppColor.yellowColor),
                                        child: const Center(
                                          child:
                                              Text("Bạn không có đơn hàng nào"),
                                        ),
                                      );
                                    }
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: AppDimention.size10,
                                            horizontal: AppDimention.size10,
                                          ),
                                          padding: EdgeInsets.all(
                                              AppDimention.size10),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimention.size10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.2))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  height: AppDimention.size60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          'Mã đơn hàng : ${orderController.orderList[index].orderCode}',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5))),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (orderController
                                                                  .orderList[
                                                                      index]
                                                                  .status !=
                                                              "Đơn hàng đã bị hủy") {
                                                            Get.toNamed(AppRoute
                                                                .get_order_detail(
                                                                    orderController
                                                                        .orderList[
                                                                            index]
                                                                        .orderCode!));
                                                          }
                                                        },
                                                        child: Container(
                                                          width: AppDimention
                                                              .size100,
                                                          height: AppDimention
                                                              .size30,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black12,
                                                                  width: 1),
                                                              color: orderController
                                                                          .orderList[
                                                                              index]
                                                                          .status ==
                                                                      "Đơn hàng đã bị hủy"
                                                                  ? AppColor
                                                                      .mainColor
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Center(
                                                            child: Text(
                                                              orderController.orderList[index].status == "Đơn hàng đã bị hủy" ? "Đã hủy " : "Chi tiết",
                                                              style: TextStyle(
                                                                  color: orderController
                                                                              .orderList[
                                                                                  index]
                                                                              .status ==
                                                                          "Đơn hàng đã bị hủy"
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Column(
                                                children: orderDetails
                                                    .map<Widget>((detail) {
                                                  ProductDetail? productOrder;
                                                  ComboDetail? comboOrder;
                                                  ComboItem? comboItem;
                                                  if (detail.type == "product") {
                                                    productOrder =
                                                        detail
                                                                .productDetail;
                                                  } else {
                                                    comboOrder =
                                                        detail.comboDetail;
                                                    comboItem = Get.find<
                                                            ComboController>()
                                                        .getComboById(
                                                            comboOrder!
                                                                .comboId!);
                                                  }

                                                  bool key =
                                                      productOrder != null;
                                                  

                                                  return Container(
                                                      padding: EdgeInsets.only(
                                                          top: AppDimention
                                                              .size10,
                                                          left: AppDimention
                                                              .size10,
                                                          bottom: AppDimention
                                                              .size20,
                                                          right: AppDimention
                                                              .size10),
                                                      width: AppDimention
                                                          .screenWidth,
                                                      margin: EdgeInsets.only(
                                                          top: AppDimention
                                                              .size10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimention
                                                                      .size10)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Sản phẩm : ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black38),
                                                                  ),
                                                                  Text(
                                                                    key
                                                                        ? productOrder
                                                                            .productName!
                                                                        : comboItem!
                                                                            .comboName!,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: AppDimention
                                                                .size10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Số lượng : ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black38),
                                                                  ),
                                                                  Text(
                                                                    key
                                                                        ? productOrder
                                                                            .quantity
                                                                            .toString()
                                                                        : comboOrder!
                                                                            .quantity
                                                                            .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black38,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                "đ${key ? productOrder.totalPrice!.toInt() : comboOrder!.totalPrice!.toInt()}",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ));
                                                }).toList(),
                                              ),
                                              Container(
                                                width: AppDimention.screenWidth,
                                                padding: EdgeInsets.only(
                                                  top: AppDimention.size10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    if (orderController
                                                            .orderList[index]
                                                            .status ==
                                                        "Đơn hàng mới")
                                                      SizedBox(
                                                          width: AppDimention
                                                                  .size100 *
                                                              3.3,
                                                          height: AppDimention
                                                              .size30,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 10,
                                                                top: 10,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTapDown:
                                                                    (details) {
                                                                  showPopover(
                                                                      context,
                                                                      details
                                                                          .globalPosition,
                                                                      "Đơn hàng mới");
                                                                },
                                                                child: const Icon(
                                                                  Icons.circle,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              )
                                                            ],
                                                          ))
                                                    else if (orderController
                                                            .orderList[index]
                                                            .status ==
                                                        "Đơn hàng đã được xác nhận")
                                                      SizedBox(
                                                          width: AppDimention
                                                                  .size100 *
                                                              3.3,
                                                          height: AppDimention
                                                              .size30,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 10,
                                                                top: 10,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 0,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đơn hàng mới");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left:
                                                                    AppDimention
                                                                        .size110,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đã xác nhận");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    else if (orderController
                                                            .orderList[index]
                                                            .status ==
                                                        "Đơn hàng đang giao")
                                                      SizedBox(
                                                          width: AppDimention
                                                                  .size100 *
                                                              3.3,
                                                          height: AppDimention
                                                              .size30,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 10,
                                                                top: 10,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 0,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đơn hàng mới");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left:
                                                                    AppDimention
                                                                        .size110,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đã xác nhận");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: AppDimention
                                                                        .size110 *
                                                                    2,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đang giao");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    else if (orderController
                                                            .orderList[index]
                                                            .status ==
                                                        "Đơn hàng đã hoàn thành")
                                                      SizedBox(
                                                          width: AppDimention
                                                                  .size100 *
                                                              3.3,
                                                          height: AppDimention
                                                              .size30,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                left: 10,
                                                                top: 10,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size100,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size100,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                    Container(
                                                                      width: AppDimention
                                                                          .size110,
                                                                      height: AppDimention
                                                                          .size5,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 0,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đã hoàn thành");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 10,
                                                                top: 0,
                                                                child: Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTapDown:
                                                                          (details) {
                                                                        showPopover(
                                                                            context,
                                                                            details.globalPosition,
                                                                            "Đã hoàn thành");
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                  ],
                                                ),
                                              ),
                                              if (orderController
                                                      .orderList[index].status
                                                      .toString() ==
                                                  "Đơn hàng mới")
                                                if (!orderController
                                                    .orderList[index].feedback!)
                                                  Container(
                                                      width: AppDimention
                                                          .screenWidth,
                                                      margin: EdgeInsets.only(
                                                          left: AppDimention
                                                              .size10,
                                                          right: AppDimention
                                                              .size10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showCancelOrder(
                                                              orderController
                                                                  .orderList[
                                                                      index]
                                                                  .orderCode!,
                                                              orderController
                                                                  .orderList[
                                                                      index]
                                                                  .status!);
                                                        },
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    AppDimention
                                                                        .size80,
                                                                height:
                                                                    AppDimention
                                                                        .size30,
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .mainColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            AppDimention.size5)),
                                                                child: const Center(
                                                                  child: Icon(Icons.delete_forever_rounded,color: Colors.white,),
                                                              
                                                               
                                                                ),
                                                              ),
                                                            ]),
                                                      )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (orderController
                                                              .orderList[index]
                                                              .status ==
                                                          "Đơn hàng đã bị hủy" ||
                                                      orderController
                                                              .orderList[index]
                                                              .status ==
                                                          "Đơn hàng đã hoàn thành")
                                                    // GestureDetector(
                                                    //   onTap: () {},
                                                    //   child: Container(
                                                    //     width: AppDimention
                                                    //         .size100,
                                                    //     height:
                                                    //         AppDimention.size30,
                                                    //     decoration: BoxDecoration(
                                                    //         border: Border.all(
                                                    //             color: Colors
                                                    //                 .black12,
                                                    //             width: 1),
                                                    //         color: Colors.white,
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .circular(
                                                    //                     5)),
                                                    //     child: Center(
                                                    //       child: Text(
                                                    //         "Mua lại",
                                                    //         style: TextStyle(
                                                    //             color: Colors
                                                    //                 .black),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  if (orderController
                                                          .orderList[index]
                                                          .status
                                                          .toString() ==
                                                      "Đơn hàng đã hoàn thành")
                                                    if (!orderController
                                                        .orderList[index]
                                                        .feedback!)
                                                      Container(
                                                          margin: EdgeInsets.only(
                                                              left: AppDimention
                                                                  .size10,
                                                              right:
                                                                  AppDimention
                                                                      .size10),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showFeedBack(
                                                                orderController
                                                                        .orderList[
                                                                    index],
                                                              );
                                                            },
                                                            child: Container(
                                                              width:
                                                                  AppDimention
                                                                      .size100,
                                                              height:
                                                                  AppDimention
                                                                      .size40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          AppDimention
                                                                              .size5)),
                                                              child: const Center(
                                                                child: Text(
                                                                  "Đánh giá",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                          : const CircularProgressIndicator();
                    },
                  ),
                )),
                GetBuilder<OrderController>(builder: (orderController) {
                  return !orderController.isLoading
                      ? Positioned(
                          top: AppDimention.size10,
                          left: AppDimention.size10,
                          width: AppDimention.size100 * 1.8,
                          height: AppDimention.size100 * 6,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isShowBar = !isShowBar;
                                      _toggleBar();
                                    });
                                  },
                                  child: AnimatedRotation(
                                    turns: isShowBar ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 500),
                                    child: Icon(
                                      Icons.add_circle,
                                      size: AppDimention.size50,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                left: 0,
                                top: AppDimention.size50,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                child: AnimatedContainer(
                                  width: AppDimention.size100 * 1.7,
                                  padding: EdgeInsets.all(AppDimention.size10),
                                  height: isShowBar
                                      ? AppDimention.size100 * 3.5
                                      : 0,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size10)),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                  child: isChildVisible
                                      ? SizedBox(
                                          width: AppDimention.size100 * 1.7,
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<OrderController>()
                                                      .getAll();
                                                  setState(() {
                                                    selectedStatus = "All";
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut, //
                                                  width: AppDimention.size150,
                                                  padding: EdgeInsets.all(
                                                      AppDimention.size15),
                                                  decoration: BoxDecoration(
                                                      color: selectedStatus ==
                                                              "All"
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: const Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Tất cả",
                                                      style: TextStyle(
                                                        color: selectedStatus ==
                                                                "All"
                                                            ? Colors.green
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<OrderController>()
                                                      .getOrderWithStatus(
                                                          "Đơn hàng mới");
                                                  setState(() {
                                                    selectedStatus =
                                                        "Đơn hàng mới";
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut, //
                                                  width: AppDimention.size150,
                                                  padding: EdgeInsets.all(
                                                      AppDimention.size15),
                                                  decoration: BoxDecoration(
                                                      color: selectedStatus ==
                                                              "Đơn hàng mới"
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: const Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Đơn hàng mới",
                                                      style: TextStyle(
                                                        color: selectedStatus ==
                                                                "Đơn hàng mới"
                                                            ? Colors.green
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<OrderController>()
                                                      .getOrderWithStatus(
                                                          "Đơn hàng đã được xác nhận");
                                                  setState(() {
                                                    selectedStatus =
                                                        "Đơn hàng đã được xác nhận";
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                  width: AppDimention.size150,
                                                  padding: EdgeInsets.all(
                                                      AppDimention.size15),
                                                  decoration: BoxDecoration(
                                                      color: selectedStatus ==
                                                              "Đơn hàng đã được xác nhận"
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: const Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Đã xác nhận",
                                                      style: TextStyle(
                                                        color: selectedStatus ==
                                                                "Đơn hàng đã được xác nhận"
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<OrderController>()
                                                      .getOrderWithStatus(
                                                          "Đơn hàng đang giao");
                                                  setState(() {
                                                    selectedStatus =
                                                        "Đơn hàng đang giao";
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                  width: AppDimention.size150,
                                                  padding: EdgeInsets.all(
                                                      AppDimention.size15),
                                                  decoration: BoxDecoration(
                                                      color: selectedStatus ==
                                                              "Đơn hàng đang giao"
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: const Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Đang giao",
                                                      style: TextStyle(
                                                        color: selectedStatus ==
                                                                "Đơn hàng đang giao"
                                                            ? Colors.yellow
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<OrderController>()
                                                      .getOrderWithStatus(
                                                          "Đơn hàng đã hoàn thành");
                                                  setState(() {
                                                    selectedStatus =
                                                        "Đơn hàng đã hoàn thành";
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                  width: AppDimention.size150,
                                                  padding: EdgeInsets.all(
                                                      AppDimention.size15),
                                                  decoration: BoxDecoration(
                                                      color: selectedStatus ==
                                                              "Đơn hàng đã hoàn thành"
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: const Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Hoàn thành",
                                                      style: TextStyle(
                                                        color: selectedStatus ==
                                                                "Đơn hàng đã hoàn thành"
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.find<OrderController>()
                                                      .getOrderWithStatus(
                                                          "Đơn hàng đã bị hủy");
                                                  setState(() {
                                                    selectedStatus =
                                                        "Đơn hàng đã bị hủy";
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                  width: AppDimention.size150,
                                                  padding: EdgeInsets.all(
                                                      AppDimention.size15),
                                                  decoration: BoxDecoration(
                                                      color: selectedStatus ==
                                                              "Đơn hàng đã bị hủy"
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                      border: const Border(
                                                        bottom: BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size10)),
                                                  child: Center(
                                                    child: Text(
                                                      "Bị hủy",
                                                      style: TextStyle(
                                                        color: selectedStatus ==
                                                                "Đơn hàng đã bị hủy"
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                })
              ]));
            }
          }),
          const OrderFooter()
        ],
      ),
    );
  }
}
