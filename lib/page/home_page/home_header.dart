import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: AppDimention.size40, bottom: AppDimention.size20),
      padding:
          EdgeInsets.only(left: AppDimention.size20, right: AppDimention.size20),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
                Get.toNamed(AppRoute.CAMERA_PAGE);
            },  
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColor.mainColor,
            ),
          ),
          SizedBox(width: AppDimention.size10),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                
                hintText: "Search ...",
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.yellowColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                ),
              ),
            ),
          ),
          SizedBox(width: AppDimention.size5,),
          GestureDetector(
            onTap: (){
                Get.toNamed(AppRoute.CART_PAGE);
            },
            child: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
    );
  }
}
