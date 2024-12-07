import 'package:android_project/page/chat_page/home_chart/home_chat.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeChatHeader extends StatefulWidget {
  const HomeChatHeader({
    super.key,
  });
  @override
  HomeChatHeaderState createState() => HomeChatHeaderState();
}

class HomeChatHeaderState extends State<HomeChatHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimention.screenWidth,
      height: AppDimention.size100 * 1.6,
      padding: EdgeInsets.only(
          left: AppDimention.size20, right: AppDimention.size20),
      decoration: const BoxDecoration(color: AppColor.mainColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                 Get.to(const HomeChat());
                },
                child: Text("Tin nhắn",
                    style: GoogleFonts.fuzzyBubbles(
                      textStyle: TextStyle(
                          fontSize: AppDimention.size30, color: Colors.white),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.STORE_CHAT_PAGE);
                },
                child: const Icon(
                  Icons.store,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.SEARCH_CHAT_PAGE);
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
