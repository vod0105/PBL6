import 'dart:convert';

import 'package:android_project/custom/big_text.dart';

import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    super.key,
  });
  @override
  ProfileHeaderState createState() => ProfileHeaderState();
}

class ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return SizedBox(
        width: AppDimention.screenWidth,
        height: AppDimention.size100 * 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(top: AppDimention.size20),
              width: AppDimention.screenWidth,
              child: Center(
                child: Text("Hồ sơ",
                    style: TextStyle(
                        fontSize: AppDimention.size25, color: Colors.white)),
              ),
            ),
            Row(
              children: [
                Container(
                  width: AppDimention.size80,
                  height: AppDimention.size80,
                  margin: EdgeInsets.only(
                      left: AppDimention.size30, top: AppDimention.size30),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (userController.userProfile?.avatar != null &&
                                  userController
                                      .userProfile!.avatar!.isNotEmpty)
                              ? MemoryImage(base64Decode(
                                  userController.userProfile!.avatar!))
                              : const AssetImage("assets/image/avatar.jpg"))),
                ),
                SizedBox(
                  width: AppDimention.size20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppDimention.size30,
                    ),
                    BigText(
                      text: userController.userProfile?.fullName ??
                          'Default Name',
                      color: Colors.white,
                    ),
                    Text(
                      "ID: ${userController.userProfile?.id}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
