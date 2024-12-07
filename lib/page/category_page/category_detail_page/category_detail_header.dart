import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailHeader extends StatefulWidget {
  final String categoryname;
  const CategoryDetailHeader({super.key, required this.categoryname});

  @override
  CategoryDetailHeaderState createState() => CategoryDetailHeaderState();
}

class CategoryDetailHeaderState extends State<CategoryDetailHeader> {
  late String title;
  @override
  void initState() {
    super.initState();
    title = widget.categoryname;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppDimention.screenWidth,
          height: AppDimention.size100,
          decoration: const BoxDecoration(color: AppColor.mainColor),
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
                  size: AppDimention.size40,
                ),
              ),
              SizedBox(
                width: AppDimention.size100 * 2,
                child: Center(
                  child: Text(
                    "CHỌN MÓN",
                    style: TextStyle(
                      fontSize: AppDimention.size20,
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
                  size: AppDimention.size40,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: AppDimention.screenWidth,
          height: AppDimention.size50,
          decoration:
              const BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: AppColor.mainColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
