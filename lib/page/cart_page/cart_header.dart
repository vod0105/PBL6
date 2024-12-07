
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';

class CartHeader extends StatefulWidget {
  const CartHeader({
    super.key,
  });
  @override
  CartHeaderState createState() => CartHeaderState();
}

class CartHeaderState extends State<CartHeader> {
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
                decoration: const BoxDecoration(color: AppColor.mainColor),
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
