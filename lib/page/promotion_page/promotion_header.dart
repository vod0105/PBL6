import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromotionHeader extends StatefulWidget {
  const PromotionHeader({
    Key? key,
  }) : super(key: key);
  @override
  _PromotionHeaderState createState() => _PromotionHeaderState();
}

class _PromotionHeaderState extends State<PromotionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimention.screenWidth,
      height: AppDimention.size100,
      decoration: BoxDecoration(color: AppColor.mainColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_circle_left_outlined,
              size: AppDimention.size40,
              color: Colors.white,
            ),
          ),
          Text("Khuyến mãi",
              style: TextStyle(
                  fontSize: AppDimention.size25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.CART_PAGE);
            },
            child: Icon(
              Icons.shopping_cart_outlined,
              size: AppDimention.size30,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
