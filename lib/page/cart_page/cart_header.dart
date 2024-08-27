import 'package:android_project/custom/big_text.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CartHeader extends StatefulWidget{
   const CartHeader({
       Key? key,
   }): super(key:key);
   @override
   _CartHeaderState createState() => _CartHeaderState();
}
class _CartHeaderState extends State<CartHeader>{
   @override
   Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container( 
                width: 390, 
                height: 130,
                child: Stack(
                  children: [
                    Positioned(
                      left: AppDimention.size10,
                      top: AppDimention.size15,
                      child: Container(
                        width: 375,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(AppDimention.size10),
                        ),
                      )
                    ),
                    Positioned(
                      top:AppDimention.size15,
                      left: AppDimention.size30 + AppDimention.size5,
                      child: Container(
                        width: AppDimention.size20 * 5,
                        height: AppDimention.size20 * 5,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 173, 253, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 58,
                      top: AppDimention.size25,
                      child: Container(
                        width: AppDimention.size80,
                        height: AppDimention.size80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimention.size80),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/image/logo.png"
                              ),
                            ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 158,
                      child: Container(
                        height: 110,
                        width: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppDimention.size25),
                            BigText(text: "Giỏ hàng của bạn",size: 25,),
                            SizedBox(height: AppDimention.size5,),                           
                          ],
                        ),
                      )
                    ),
                    Positioned(
                      top: 90,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(50)
                          ),
                          border: Border(
                            bottom: BorderSide(width: 1),
                            right: BorderSide(width: 1)
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.av_timer_rounded,color:Color.fromRGBO(138, 206, 255, 1),),
                            Text(
                              "Hiện đang có 3 sản phẩm",
                              style: TextStyle(
                                color: AppColor.mainColor
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      child: GestureDetector(
                        onTap: (){
                            Get.back();
                        },
                        child: Icon(Icons.arrow_circle_left_rounded ,size: 50,color:Color.fromRGBO(138, 206, 255, 1)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )

        ],
      );
   }
}