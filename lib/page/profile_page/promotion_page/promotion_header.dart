
import 'package:android_project/page/profile_page/promotion_page/user_promotion.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromotionHeader extends StatefulWidget {
  const PromotionHeader({
    super.key,
  });
  @override
  PromotionHeaderState createState() => PromotionHeaderState();
}

class PromotionHeaderState extends State<PromotionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimention.screenWidth,
      height: AppDimention.size70,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: Colors.black26))
      ),
      child: Row(
        
        children: [
          SizedBox(width: AppDimention.size10,),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: AppDimention.size20,
              color: Colors.black,
            ),
          ),
         SizedBox(
          width: AppDimention.size100 * 3,
          child: Center(
            child:  Text("Khuyến mãi",
              style: TextStyle(
                  fontSize: AppDimention.size25,
                  color: Colors.black,
            )),
          ),
         ),
         GestureDetector(
          onTap:(){
              Get.to(const UserPromotion());
          },
          child:const Text("Kho"),
         )
         
        ],
      ),
    );
  }
}
