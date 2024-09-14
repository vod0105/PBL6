import 'dart:convert';
import 'dart:typed_data';
import 'package:android_project/custom/big_text.dart';
import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/route/app_route.dart';
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
                  
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                         
                          height: AppDimention.size60,
                           decoration: BoxDecoration(
                              color: Colors.red, 
                              borderRadius: BorderRadius.circular(10),
                            ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Mã đơn hàng : ${orderController.orderlist[index].orderCode}', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                              GestureDetector(
                                onTap: (){
                                    Get.toNamed(AppRoute.get_order_detail(orderController.orderlist[index].orderCode!));
                                },
                                child: Container(
                                  width: AppDimention.size100,
                                  height: AppDimention.size30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child: Text("Chi tiết",style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        Column(
                          children: orderDetails.map<Widget>((detail) {
                            var productOrder = detail.productDetail;
                            var comboOrder = detail.comboDetail;
                            bool key = productOrder != null;
                            Uint8List decodeImage() {
                                if (productOrder != null && productOrder.productImage != null) {
                                  try {
                                    return base64Decode(productOrder.productImage!);
                                  } catch (e) {
                                    print("Error decoding product image: $e");
                                    return Uint8List(0);
                                  }
                                } 
                                else {
                                  try {
                                    return base64Decode(comboOrder!.combo!.image!);
                                  } catch (e) {
                                    print("Error decoding combo image: $e");
                                    return Uint8List(0);
                                  }
                                }
                               
                              }
                            return Container(
                              padding: EdgeInsets.only(top: AppDimention.size10,left: AppDimention.size10,bottom: AppDimention.size20,right: AppDimention.size10),
                              width: AppDimention.screenWidth,
                              margin: EdgeInsets.only(top: AppDimention.size10),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(AppDimention.size10)
                              ),

                              child: 
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                      decodeImage()
                                                    ),

                                                  ),
                                              ),
                                            ),
                                            SizedBox(width: AppDimention.size40,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  key
                                                      ? productOrder?.productName ?? "No name"
                                                      : comboOrder?.combo?.comboName ?? "No name",
                                                  style: TextStyle(color: Colors.black,fontSize: AppDimention.size25,fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: AppDimention.size10,),
                                                Text(
                                                  "Giá : ${key ? productOrder?.unitPrice : comboOrder?.unitPrice} vnđ",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                SizedBox(height: AppDimention.size10,),
                                                Text(
                                                  "Số lượng : ${key ? productOrder?.quantity : comboOrder?.quantity}",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                SizedBox(height: AppDimention.size10,),
                                                Container(
                                                    width: 200, // Chiều rộng tối đa mong muốn
                                                    child: Text(
                                                      "Ngày đặt : ${orderController.orderlist[index].orderDate}",
                                                      style: TextStyle(color: Colors.black),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  )

                                              ],
                                            )
                                          ],
                                        ),
                                         
                                      ],
                                    )
                              
                            
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: AppDimention.screenWidth,
                    margin: EdgeInsets.only(left: AppDimention.size10,right: AppDimention.size10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Row(
                          children: [
                             Icon(Icons.today_outlined,size: AppDimention.size30,),
                            SizedBox(width: AppDimention.size10,),
                            Text(orderController.orderlist[index].totalAmount.toString() +" vnđ ",style: TextStyle())
                          ],
                         ),
                         Text(orderController.orderlist[index].status.toString(),)
                        ],
                      ),
                  ),
                  SizedBox(height: AppDimention.size40,)
              ],
            );
          },
        );
      },
    );
  }
}
