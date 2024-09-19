import 'package:android_project/custom/big_text.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartHeader extends StatefulWidget {
  const CartHeader({
    Key? key,
  }) : super(key: key);
  @override
  _CartHeaderState createState() => _CartHeaderState();
}

class _CartHeaderState extends State<CartHeader> {
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
                decoration: BoxDecoration(color: AppColor.mainColor),
                child: Center(
                  child: Text(
                    "Phần ăn đã chọn",
                    style: TextStyle(
                        color: Colors.white, fontSize: AppDimention.size30),
                  ),
                )),
          ],
        )
      ],
    );
  }
}
