import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  HomeHeaderState createState() => HomeHeaderState();
}

class HomeHeaderState extends State<HomeHeader> {
  final TextEditingController searchController = TextEditingController();
  final authController = Get.find<AuthController>();
  late int lenGhtCart = 0;
  @override
  void initState() {
    super.initState();
    lenGhtCart = Get.find<CartController>().cartList.length;
  }

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
      padding: EdgeInsets.only(
          left: AppDimention.size20, right: AppDimention.size20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoute.PROFILE_PAGE);
            },
            child: Row(
            children: [
              const Text("Chào mừng ",style: TextStyle(
                color: Colors.black45
              ),),
              Text("${Get.find<UserController>().userProfile!.fullName}",style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),),
            ],
          ),
          ),
          SizedBox(width: AppDimention.size10),
          Obx(() {
            if (!authController.isLogin.value) {
              return Container();
            } else {
              return SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.CART_PAGE);
                        },
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                          size: AppDimention.size30,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                          color: AppColor.mainColor,
                        ),
                        child: SizedBox(
                            width: AppDimention.size10,
                            height: AppDimention.size10,
                            child: Center(
                              child: Text(
                                lenGhtCart.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
