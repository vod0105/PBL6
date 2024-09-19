import 'dart:convert';
import 'dart:typed_data';

import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/models/Model/OrderModel.dart';
import 'package:android_project/page/order_page/order_footer.dart';
import 'package:android_project/page/order_page/order_header.dart';
import 'package:android_project/page/order_page/order_list.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
  }) : super(key: key);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isChildVisible = false;
  TextEditingController feedbackController = TextEditingController();

  String _selectedRating = "5 sao";
  void _ShowFeedBack(OrderItem item) {
    var orderDetails = item.orderDetails;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đánh giá sản phẩm'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                width: AppDimention.size100 * 3,
                height: AppDimention.size100 * 4.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Radio(
                              value: "1 sao",
                              groupValue: _selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRating = value.toString();
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text("1"),
                                Icon(
                                  Icons.star,
                                  color: AppColor.mainColor,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Radio(
                              value: "2 sao",
                              groupValue: _selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRating = value.toString();
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text("2"),
                                Icon(
                                  Icons.star,
                                  color: AppColor.mainColor,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Radio(
                              value: "3 sao",
                              groupValue: _selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRating = value.toString();
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text("3"),
                                Icon(
                                  Icons.star,
                                  color: AppColor.mainColor,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Radio(
                              value: "4 sao",
                              groupValue: _selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRating = value.toString();
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text("4"),
                                Icon(
                                  Icons.star,
                                  color: AppColor.mainColor,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Radio(
                              value: "5 sao",
                              groupValue: _selectedRating,
                              onChanged: (value) {
                                setState(() {
                                  _selectedRating = value.toString();
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text("5"),
                                Icon(
                                  Icons.star,
                                  color: AppColor.mainColor,
                                  size: 12,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    Container(
                      width: AppDimention.size100 * 3,
                      height: AppDimention.size100 * 3,
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
                        _sendFeedBack();
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size10)),
                        child: Center(
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

  void _sendFeedBack() {
    String rate = _selectedRating;
    String feedbackMessage = feedbackController.text;
    //send feed back
  }

  void _toggleBar() {
    if (isShowBar) {
      Future.delayed(Duration(milliseconds: 200), () {
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

  @override
  void initState() {
    super.initState();
    if (Get.find<OrderController>().isShowAll == 0)
      Get.find<OrderController>().getall();
  }

  bool isShowBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          OrderHeader(),
          Expanded(
              child: Stack(children: [
            Positioned(child: SingleChildScrollView(
              child: GetBuilder<OrderController>(
                builder: (orderController) {
                  return !orderController.isLoading
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orderController.orderlist.length,
                          itemBuilder: (context, index) {
                            var orderDetails =
                                orderController.orderlist[index].orderDetails;
                            if (orderDetails == null || orderDetails.isEmpty) {
                              return Container(
                                width: AppDimention.screenWidth,
                                height: 200,
                                decoration:
                                    BoxDecoration(color: AppColor.yellowColor),
                                child: Center(
                                  child: Text("Bạn không có đơn hàng nào"),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: AppDimention.size60,
                                          decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                      255, 255, 75, 75),
                                                  spreadRadius: 10,
                                                  blurRadius: 10,
                                                  offset: Offset(2, 4),
                                                ),
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  'Mã đơn hàng : ${orderController.orderlist[index].orderCode}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRoute.get_order_detail(
                                                          orderController
                                                              .orderlist[index]
                                                              .orderCode!));
                                                },
                                                child: Container(
                                                  width: AppDimention.size100,
                                                  height: AppDimention.size30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text(
                                                      "Chi tiết",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Column(
                                        children:
                                            orderDetails.map<Widget>((detail) {
                                          var productOrder =
                                              detail.productDetail;
                                          var comboOrder = detail.comboDetail;
                                          bool key = productOrder != null;
                                          Uint8List decodeImage() {
                                            if (productOrder != null &&
                                                productOrder.productImage !=
                                                    null) {
                                              try {
                                                return base64Decode(
                                                    productOrder.productImage!);
                                              } catch (e) {
                                                print(
                                                    "Error decoding product image: $e");
                                                return Uint8List(0);
                                              }
                                            } else {
                                              try {
                                                return base64Decode(
                                                    comboOrder!.combo!.image!);
                                              } catch (e) {
                                                print(
                                                    "Error decoding combo image: $e");
                                                return Uint8List(0);
                                              }
                                            }
                                          }

                                          return Container(
                                              padding: EdgeInsets.only(
                                                  top: AppDimention.size10,
                                                  left: AppDimention.size10,
                                                  bottom: AppDimention.size20,
                                                  right: AppDimention.size10),
                                              width: AppDimention.screenWidth,
                                              margin: EdgeInsets.only(
                                                  top: AppDimention.size10),
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size10)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: MemoryImage(
                                                                decodeImage()),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            AppDimention.size40,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            key
                                                                ? productOrder
                                                                        ?.productName ??
                                                                    "No name"
                                                                : comboOrder
                                                                        ?.combo
                                                                        ?.comboName ??
                                                                    "No name",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    AppDimention
                                                                        .size25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: AppDimention
                                                                .size10,
                                                          ),
                                                          Text(
                                                            "Giá : ${key ? productOrder?.unitPrice : comboOrder?.unitPrice} vnđ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: AppDimention
                                                                .size10,
                                                          ),
                                                          Text(
                                                            "Số lượng : ${key ? productOrder?.quantity : comboOrder?.quantity}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: AppDimention
                                                                .size10,
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            child: Text(
                                                              "Ngày đặt : ${orderController.orderlist[index].orderDate}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: AppDimention.screenWidth,
                                  margin: EdgeInsets.only(
                                      left: AppDimention.size10,
                                      right: AppDimention.size10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.today_outlined,
                                            size: AppDimention.size30,
                                          ),
                                          SizedBox(
                                            width: AppDimention.size10,
                                          ),
                                          Text(
                                              orderController.orderlist[index]
                                                      .totalAmount
                                                      .toString() +
                                                  " vnđ ",
                                              style: TextStyle())
                                        ],
                                      ),
                                      Text(
                                        orderController.orderlist[index].status
                                            .toString(),
                                      ),
                                      if (orderController
                                              .orderlist[index].status
                                              .toString() ==
                                          "Đã hoàn thành")
                                        GestureDetector(
                                          onTap: () {
                                            _ShowFeedBack(orderController
                                                .orderlist[index]);
                                          },
                                          child: Text("Đánh giá"),
                                        )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimention.size40,
                                )
                              ],
                            );
                          },
                        )
                      : CircularProgressIndicator();
                },
              ),
            )),
            GetBuilder<OrderController>(builder: (orderController) {
              return !orderController.isLoading
                  ? Positioned(
                      top: AppDimention.size10,
                      left: AppDimention.size10,
                      width: 100,
                      height: 400,
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
                                duration: Duration(milliseconds: 500),
                                child: Icon(
                                  Icons.add_circle,
                                  size: AppDimention.size50,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shadows: [
                                    Shadow(blurRadius: 10, offset: Offset(2, 4))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            left: 0,
                            top: 50,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                            child: AnimatedContainer(
                              width: 50,
                              height: isShowBar ? 250 : 0,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      width: 1, color: Colors.black26),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size40)),
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                              child: isChildVisible
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.find<OrderController>()
                                                .getorderWithStatus(
                                                    "Đơn hàng đã được xác nhận");
                                          },
                                          child: Icon(
                                              Icons.card_travel_outlined,
                                              size: AppDimention.size25),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.find<OrderController>()
                                                .getorderWithStatus(
                                                    "Đang lấy hàng");
                                          },
                                          child: Icon(Icons.present_to_all,
                                              size: AppDimention.size25),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.find<OrderController>()
                                                .getorderWithStatus(
                                                    "Đang giao");
                                          },
                                          child: Icon(
                                              Icons.delivery_dining_outlined,
                                              size: AppDimention.size25),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.find<OrderController>()
                                                .getorderWithStatus(
                                                    "Đã hoàn thành");
                                          },
                                          child: Icon(
                                              Icons.star_border_purple500_sharp,
                                              size: AppDimention.size25),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container();
            })
          ])),
          OrderFooter()
        ],
      ),
    );
  }
}
