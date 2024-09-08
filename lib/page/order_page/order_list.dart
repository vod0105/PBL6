import 'dart:convert';

import 'package:android_project/custom/big_text.dart';
import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderList extends StatefulWidget {
  const OrderList({
    Key? key,
  }) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        if (orderController.orderlist.isEmpty) {
          return Container(
            width: 400,
            height: 175,
            child: Center(
              child: Text("Bạn không có món ăn trong đơn hàng"),
            ),
          );
        }
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orderController.orderlist.length,
          itemBuilder: (context, index) {
            var orderDetails = orderController.orderlist[index].orderDetails;
            if (orderDetails == null || orderDetails.isEmpty) {
              return Container(); 
            }
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(
                      vertical: AppDimention.size10, 
                      horizontal: AppDimention.size10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red, 
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: AppDimention.size10),
                          child: Text('Mã đơn hàng : ${orderController.orderlist[index].orderCode}', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Column(
                          children: orderDetails.map<Widget>((detail) {
                            var productOrder = detail.productDetail;
                            var comboOrder = detail.comboDetail;
                            bool key = productOrder != null;
                            return Container(
                              padding: EdgeInsets.all(AppDimention.size10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: MemoryImage(base64Decode(key ? (productOrder?.productImage ?? '') : (comboOrder?.combo?.image ?? ''))
                                                      ),
                                                    ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimention.size10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: key
                                              ? productOrder?.productName ?? "No name"
                                              : comboOrder?.combo?.comboName ?? "No name",
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Giá : ${key ? productOrder?.totalPrice : comboOrder?.totalPrice} vnđ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          "Ngày đặt ${orderController.orderlist[index].orderDate}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        
                                        SizedBox(height: AppDimention.size10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 120,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width: 1, color: Colors.white),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                    "Số lượng : ${key ? productOrder?.quantity : comboOrder?.quantity}",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                
                                              ],
                                            ),
                                            Row(
                                              children: [
                                              
                                                SizedBox(width: 30),
                                                Container(
                                                  child: Center(
                                                    child: orderController.orderlist[index].status == "Đang chờ " ? Icon(Icons.delete_outline, color: Colors.red) : Text("Không thể hủy đơn"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: AppDimention.size10),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimention.size20),
                                color: Colors.grey
                              ),
                            ),
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimention.size20),
                                color: Colors.greenAccent
                              ),
                            ),
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimention.size20),
                                color: Colors.grey
                              ),
                            ),
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppDimention.size20),
                                color: Colors.grey
                              ),
                            ),
                          ],
                    ),
                    Container(
                      width: AppDimention.screenWidth,
                      height: 50,
                      margin: EdgeInsets.only(left: 10,right: 10),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(width: 1),right: BorderSide(width: 1),bottom: BorderSide(width: 1)),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                      ),
                      child: Center(
                        child: Text("Tổng giá : ${orderController.orderlist[index].totalAmount} vnđ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: AppDimention.size50,)
                  
                    ],
                  )
                
              ],
            );
          },
        );
      },
    );
  }
}
