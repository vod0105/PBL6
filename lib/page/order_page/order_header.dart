import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';

class OrderHeader extends StatefulWidget {
  const OrderHeader({
    super.key,
  });
  @override
  OrderHeaderState createState() => OrderHeaderState();
}

class OrderHeaderState extends State<OrderHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        
      width: AppDimention.screenWidth,
      margin: EdgeInsets.only(top: AppDimention.size20),
      height: AppDimention.size60,
        child: const Center(
          child: Text(
            "Đơn hàng của bạn",
            style: TextStyle(color: AppColor.mainColor, fontSize: 20),
          ),
        ));
  }
}
