import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OrderFooter extends StatefulWidget{
   const OrderFooter({
       Key? key,
   }): super(key:key);
   @override
   _OrderFooterState createState() => _OrderFooterState();
}
class _OrderFooterState extends State<OrderFooter>{
   @override
   Widget build(BuildContext context) {
      return Container(
        width: AppDimention.screenWidth,
        height: AppDimention.size60,
        decoration: BoxDecoration(
          color: AppColor.yellowColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 15,),
              ),
            ),
            Row(
              children: [
                Text("Tổng tiền: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text("500.000 vnđ ",style: TextStyle(fontSize: 18),),
              ],
            ),
            Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Text("Mua ngay",style: TextStyle(color: Colors.white,fontSize: 16),),
              ),
            )
          ],
        ),
      );

   }
}