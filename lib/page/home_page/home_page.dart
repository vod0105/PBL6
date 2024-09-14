
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/page/home_page/home_banner.dart';
import 'package:android_project/page/home_page/home_combo.dart';
import 'package:android_project/page/home_page/home_folder.dart';
import 'package:android_project/page/home_page/home_footer.dart';
import 'package:android_project/page/home_page/home_header.dart';
import 'package:android_project/page/home_page/home_list_product.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends StatefulWidget{
   const HomePage({
       Key? key,
   }): super(key:key);
   @override
   _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
   @override
   Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                    HomeBanner(),
                    HomeFolder(),
                    SizedBox(height: AppDimention.size15,),
                 
                    SizedBox(height: AppDimention.size15,),
                    HomeCombo(),
                    SizedBox(height: AppDimention.size15,),
                    
                    SizedBox(height: AppDimention.size15,),
                    HomeListProduct(),
                    if(Get.find<ProductController>().productList.length > 10)
                      Container(
                        width: AppDimention.screenWidth,
                        height: 50,
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoute.SEARCH_PAGE);
                            },
                            child: Text("Xem thêm"),
                          ),
                        ),
                      )
                   
                ],
              ),
              
            )
            ),
             HomeFooter(),
            
          ],
        ),
      );
   }
}