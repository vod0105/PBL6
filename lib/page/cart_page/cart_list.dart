import 'dart:convert';

import 'package:android_project/custom/big_text.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartList extends StatefulWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return 
          GetBuilder<CartController>(builder: (cartcontroler){
             return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cartcontroler.cartlist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 375,
                  height: 175,
                  margin: EdgeInsets.only(
                      bottom: AppDimention.size10,
                      left: AppDimention.size10,
                      right: AppDimention.size10),
                 
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                         width: 370,
                          decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))
                        ),
                 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppDimention.size10,
                            ),
                            BigText(text:cartcontroler.cartlist[index].productName),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(base64Decode(cartcontroler.cartlist[index].image!)),
                                        ),
                                      
                                   ),
                                ),
                                SizedBox(width: AppDimention.size10,),
                                Container(
                                  width: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text("Giá : "+ cartcontroler.cartlist[index].unitPrice.toString(),style: TextStyle(color: AppColor.mainColor),),
                                    Text("Đánh giá  : 4.9",style: TextStyle(color: Colors.blue[300])),
                                    Text(
                                        "54,Nguyễn Lương Bằng , Liên Chiểu , Đà Nẵng",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              height: AppDimention.size30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                      GestureDetector(
                                        onTap:(){
                                          // giam so luong
                                        },
                                        child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Icon(Icons.remove,color: Colors.white,),
                                            ),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Container(
                                          width: 60,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Center(
                                            child: Text(cartcontroler.cartlist[index].quantity.toString()),
                                          ),
                                      ),
                                      SizedBox(width: 5,),
                                      GestureDetector(
                                        onTap:(){
                                          // tang so luong
                                        },
                                        child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: AppColor.mainColor,
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Icon(Icons.add,color: Colors.white,),
                                            ),
                                        ),
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Icon(Icons.border_color,color: Colors.green[400],),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    Container(
                                      child: Center(
                                        child: Icon(Icons.delete_outline,color: AppColor.mainColor,),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          });
       
  }
}
