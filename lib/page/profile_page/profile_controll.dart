import 'package:android_project/custom/select_profile_custom.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfileControll extends StatefulWidget {
  const ProfileControll({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileControllState createState() => _ProfileControllState();
}

class _ProfileControllState extends State<ProfileControll> {
  Color _rowColor = Colors.transparent;
  Color _rowColor1 = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 373,
      height: 277,
      padding: EdgeInsets.all(AppDimention.size10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimention.size10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          
          GestureDetector(
            onTap: (){
               Get.toNamed(AppRoute.CART_PAGE);
            },
            onTapDown: (_) {
              setState(() {
                _rowColor = Colors.grey.withOpacity(0.3); 
              });
            },
            onTapUp: (_) {
              setState(() {
                _rowColor = Colors.transparent; 
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _rowColor, 
                  borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              
              padding: EdgeInsets.symmetric(vertical: AppDimention.size10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectProfileCustom(
                    icon: Icons.shopping_cart,
                    title: "Giỏ hàng của bạn",
                    smalltext: "Hiện có 0 sản phẩm",
                  ),
                  Icon(
                    Icons.arrow_right_rounded,
                    size: AppDimention.size80,
                    color: AppColor.mainColor,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
               
            },
            onTapDown: (_) {
              setState(() {
                _rowColor1 = Colors.grey.withOpacity(0.3); 
              });
            },
            onTapUp: (_) {
              setState(() {
                _rowColor1 = Colors.transparent; 
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _rowColor1, 
                  borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              
              padding: EdgeInsets.symmetric(vertical: AppDimention.size10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectProfileCustom(
                    icon: Icons.delivery_dining,
                    title: "Đơn hàng của bạn",
                    smalltext: "Hiện có 2 sản phẩm",
                  ),
                  Icon(
                    Icons.arrow_right_rounded,
                    size: AppDimention.size80,
                    color: AppColor.mainColor,
                  ),
                ],
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}
