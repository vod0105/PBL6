import 'package:android_project/custom/container_folder_custom.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeFolder extends StatefulWidget{
   const HomeFolder({
       Key? key,
   }): super(key:key);
   @override
   _HomeFolderState createState() => _HomeFolderState();
}
class _HomeFolderState extends State<HomeFolder>{
   @override
   Widget build(BuildContext context) {
   // TODO: implement build
       return Container(
        height: AppDimention.size40 + 2 * AppDimention.size100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.PROMOTION_PAGE);
                    },
                    child: ContainerFolderCustom(iconData: Icons.discount_outlined, text: "Khuyến mãi",iconcolor: const Color.fromARGB(255, 151, 241, 155),),
                  ),
                  GestureDetector(
                    onTap: (){
                        Get.toNamed(AppRoute.CATEGORY_PAGE);
                    },
                    child: ContainerFolderCustom(iconData: Icons.local_drink_outlined, text: "Thực đơn",iconcolor: AppColor.yellowColor,),
                  )
                 
                ],
              ),
              Row(
                children: [
                 GestureDetector(
                  onTap: (){
                      Get.toNamed(AppRoute.STORE_PAGE);
                  },
                  child: ContainerFolderCustom(iconData: Icons.store, text: "Cửa hàng",iconcolor: Color.fromRGBO(37, 203, 245, 1),),
                 ),
                 GestureDetector(
                  onTap:(){
                      Get.toNamed(AppRoute.ORDER_PAGE);
                  },
                  child: ContainerFolderCustom(iconData: Icons.note_alt_outlined, text: "Đơn hàng gần đây",iconcolor: Color.fromRGBO(36, 255, 200, 1)),
                 )
                ],
              )
            ],
          ),
       );
   }
}