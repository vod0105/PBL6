
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailHeader extends StatefulWidget {
  const CategoryDetailHeader({Key? key}) : super(key: key);

  @override
  _CategoryDetailHeaderState createState() => _CategoryDetailHeaderState();
}

class _CategoryDetailHeaderState extends State<CategoryDetailHeader> {

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            height: 100,
            decoration: BoxDecoration(color: AppColor.mainColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.highlight_remove_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Container(
                  width: 200,
                  child: Center(
                    child: Text(
                      "CHỌN MÓN",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.CART_PAGE);
                  },
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: AppDimention.screenWidth,
            height: 50,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1))
            ),
            child: Center(
              child: Text("Gà giòn vui vẻ",style: TextStyle(color: AppColor.mainColor,fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          )
          
        ],
      );
  }
}
