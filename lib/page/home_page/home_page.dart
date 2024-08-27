import 'package:android_project/custom/big_text.dart';
import 'package:android_project/page/home_page/home_banner.dart';
import 'package:android_project/page/home_page/home_category.dart';
import 'package:android_project/page/home_page/home_folder.dart';
import 'package:android_project/page/home_page/home_footer.dart';
import 'package:android_project/page/home_page/home_header.dart';
import 'package:android_project/page/home_page/home_list_product.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
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
                    Container(   
                      margin: EdgeInsets.only(left: AppDimention.size10,right: AppDimention.size10),
                      child: BigText(text: "Category",size: 30,),
                    ),
                    SizedBox(height: AppDimention.size15,),
                    HomeCategory(),
                    SizedBox(height: AppDimention.size15,),
                    Container(   
                      margin: EdgeInsets.only(left: AppDimention.size10,right: AppDimention.size10),
                      child: BigText(text: "Product",size: 30,),
                    ),
                    SizedBox(height: AppDimention.size15,),
                    HomeListProduct(),
                   
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