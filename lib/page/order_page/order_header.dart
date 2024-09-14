
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class OrderHeader extends StatefulWidget{
   const OrderHeader({
       Key? key,
   }): super(key:key);
   @override
   _OrderHeaderState createState() => _OrderHeaderState();
}
class _OrderHeaderState extends State<OrderHeader>{
   @override
   Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container( 
                width: AppDimention.screenWidth, 
                height: 60,
                decoration: BoxDecoration(
                    color: AppColor.mainColor
                ),
                child: Center(
                  child: Text("Đơn hàng của bạn",style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  ),),
                )
              ),
            ],
          )

        ],
      );
   }
}