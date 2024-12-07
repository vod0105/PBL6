// ignore_for_file: library_private_types_in_public_api

import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/page/profile_page/profile_controll.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:android_project/page/profile_page/profile_header.dart';
import 'package:android_project/page/profile_page/profile_setting.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: Stack(
        children: [
         
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/Frame.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
         
          Column(
            children: [
              Obx(() {
                if (!authController.isLogin.value) {
                  return Expanded(
                    
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.LOGIN_PAGE);
                        },
                        child: const Center(
                          child: Text("Vui lòng đăng nhập"),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const ProfileHeader(),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const ProfileControll(),
                          const ProfileSetting(),
                        ],
                      ),
                    ),
                  );
                }
              }),
              const ProfileFooter(),
            ],
          ),
        ],
      ),
    );
  }
}
