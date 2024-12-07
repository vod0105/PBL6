import 'dart:math';

import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';

import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notification extends StatefulWidget {
  const Notification({
    super.key,
  });
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  final List<Color> colors = [
    const Color.fromARGB(255, 255, 92, 146), // Màu 1
    const Color.fromARGB(255, 92, 255, 146), // Màu 2
    const Color.fromARGB(255, 146, 92, 255), // Màu 3
    const Color.fromARGB(255, 255, 146, 92), // Màu 4
  ];
  bool isShowAll = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size70,
            decoration: const BoxDecoration(color: AppColor.mainColor),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: AppDimention.size70,
                    height: AppDimention.size70,
                    child: Center(
                      child: Icon(
                        Icons.arrow_circle_left,
                        size: AppDimention.size30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppDimention.size100 * 2.5,
                  height: AppDimention.size70,
                  child: Center(
                    child: Text(
                      "Thông báo",
                      style: TextStyle(
                          fontSize: AppDimention.size20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AppDimention.size30,
                ),
                Container(
                    width: AppDimention.screenWidth,
                    padding: EdgeInsets.all(AppDimention.size5),
                    child:
                        GetBuilder<UserController>(builder: (userController) {
                      return userController.loadingAnnoUce
                          ? const CircularProgressIndicator()
                          : Column(
                              children: [
                                Column(
                                  children: userController
                                      .listAnnoUce.reversed
                                      .take(isShowAll
                                          ? userController.listAnnoUce.length
                                          : 6)
                                      .map((item) {
                                    Color randomColor =
                                        colors[Random().nextInt(colors.length)];
                                    return Container(
                                        width: AppDimention.screenWidth,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                AppDimention.size10)),
                                        margin: EdgeInsets.only(
                                            left: AppDimention.size10,
                                            right: AppDimention.size10,
                                            bottom: AppDimention.size10),
                                        child: Container(
                                          width: AppDimention.screenWidth,
                                          padding: EdgeInsets.all(
                                              AppDimention.size10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: AppDimention.size50,
                                                height: AppDimention.size50,
                                                decoration: BoxDecoration(
                                                    color: randomColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimention
                                                                .size30)),
                                                child: const Icon(
                                                  Icons.generating_tokens,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    AppDimention.size100 * 2.7,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${item.title}",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "${item.content}",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black38),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ));
                                  }).toList(),
                                ),
                                Center(
                                  child: isShowAll ? GestureDetector(
                                    onTap: (){
                              
                                      setState(() {
                                        isShowAll = false;
                                      });
                                    },
                                    child: const Icon(Icons.keyboard_arrow_up_rounded),
                                  ) : GestureDetector(
                                    onTap: (){
                                         setState(() {
                                        isShowAll = true;
                                      });
                                    },
                                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                                  )
                                )
                              ],
                            );
                    }))
              ],
            ),
          )),
          const ProfileFooter(),
        ],
      ),
    );
  }
}
