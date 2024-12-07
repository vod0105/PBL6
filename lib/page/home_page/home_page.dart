// ignore_for_file: library_private_types_in_public_api

import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/page/home_page/home_banner.dart';
import 'package:android_project/page/home_page/home_combo.dart';
import 'package:android_project/page/home_page/home_folder.dart';
import 'package:android_project/page/home_page/home_footer.dart';
import 'package:android_project/page/home_page/home_header.dart';
import 'package:android_project/page/home_page/home_product_bestseller.dart';
import 'package:android_project/page/home_page/home_product_recommend.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  const Color(0xFFF4F4F4),
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeBanner(),
                const HomeFolder(),
                SizedBox(
                  height: AppDimention.size15,
                ),
           
                 Row(
                  children: [
                    SizedBox(width: AppDimention.size10,),
                    Text("Combo trong tuần",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black.withOpacity(0.7)),),
                  ],
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
                const HomeCombo(),
                SizedBox(
                  height: AppDimention.size15,
                ),
                SizedBox(
                  height: AppDimention.size15,
                ),
                const HomeProductRecommend(),
                SizedBox(
                  height: AppDimention.size15,
                ),
                const HomeProductBestseller(),
                
                if (Get.find<ProductController>().productList.length > 10)
                  SizedBox(
                    width: AppDimention.screenWidth,
                    height: 50,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.SEARCH_PAGE);
                        },
                        child: const Text("Xem thêm"),
                      ),
                    ),
                  )
              ],
            ),
          )),
          const HomeFooter(),
        ],
      ),
    );
  }
}
