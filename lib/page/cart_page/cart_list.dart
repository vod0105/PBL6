import 'dart:convert';
import 'package:android_project/custom/big_text.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<bool> isSelected = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      if (isSelected.length != cartController.cartlist.length) {
        isSelected = List<bool>.filled(cartController.cartlist.length, false);
      }

      if (cartController.cartlist.length < 1) {
        return Container(
          width: AppDimention.screenWidth,
          height: AppDimention.size170 + AppDimention.size5,
          child: Center(
            child: Text("Bạn không có món ăn trong giỏ hàng"),
          ),
        );
      } else {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cartController.cartlist.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: AppDimention.screenWidth - AppDimention.size100,
                height: AppDimention.size170 + AppDimention.size10,
                margin: EdgeInsets.only(
                  bottom: AppDimention.size10,
                  left: AppDimention.size10,
                  right: AppDimention.size10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isSelected[index],
                      onChanged: (bool? value) {
                        setState(() {
                          isSelected[index] = value!;
                          var id = cartController.cartlist[index].cartId;
                          cartController.cartlist[index].product != null
                              ? cartController.updateIDSelectedProduct(
                                  id, value)
                              : cartController.updateIDSelectedCombo(id, value);
                        });
                      },
                    ),
                    Container(
                      width: AppDimention.screenWidth - AppDimention.size100,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          BigText(
                            text: cartController.cartlist[index].product != null
                                ? cartController
                                    .cartlist[index].product.productName
                                : cartController.cartlist[index].combo.comboName
                                    .toString(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: AppDimention.size60,
                                height: AppDimention.size60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: MemoryImage(base64Decode(
                                      cartController.cartlist[index].product !=
                                              null
                                          ? cartController
                                              .cartlist[index].product.image!
                                          : cartController
                                              .cartlist[index].combo.image!,
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(width: AppDimention.size10),
                              Container(
                                width:
                                    AppDimention.size220 - AppDimention.size20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Giá : " +
                                          (cartController.cartlist[index]
                                                      .product !=
                                                  null
                                              ? cartController.cartlist[index]
                                                  .product!.unitPrice
                                                  .toString()
                                              : cartController.cartlist[index]
                                                  .combo!.unitPrice
                                                  .toString()),
                                      style:
                                          TextStyle(color: AppColor.mainColor),
                                    ),
                                    Text(
                                      "Size : " +
                                          (cartController.cartlist[index]
                                                      .product !=
                                                  null
                                              ? cartController
                                                  .cartlist[index].product.size
                                                  .toString()
                                              : cartController
                                                  .cartlist[index].combo.size
                                                  .toString()),
                                      style: TextStyle(color: Colors.blue[300]),
                                    ),
                                    // FutureBuilder to load store name
                                    FutureBuilder<String>(
                                      future: Get.find<Storecontroller>()
                                          .getnamestoreByid(
                                        cartController
                                                    .cartlist[index].product !=
                                                null
                                            ? cartController
                                                .cartlist[index].product.storeId
                                            : cartController
                                                .cartlist[index].combo.storeId,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text("Loading...");
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              "Error loading store name");
                                        } else {
                                          return Text(
                                            snapshot.data ?? "No store name",
                                            overflow: TextOverflow.ellipsis,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppDimention.size20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: AppDimention.size30,
                                      height: AppDimention.size30,
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 2 * AppDimention.size30,
                                    height: AppDimention.size30,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        cartController
                                                    .cartlist[index].product !=
                                                null
                                            ? cartController.cartlist[index]
                                                .product.quantity
                                                .toString()
                                            : cartController
                                                .cartlist[index].combo.quantity
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: AppDimention.size30,
                                      height: AppDimention.size30,
                                      decoration: BoxDecoration(
                                          color: AppColor.mainColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.border_color,
                                        color: Colors.green[400],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimention.size30),
                                  Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}
