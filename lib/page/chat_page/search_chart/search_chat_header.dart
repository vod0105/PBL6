import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/page/chat_page/home_chart/home_chat.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchChatHeader extends StatefulWidget {
  const SearchChatHeader({
    super.key,
  });
  @override
  SearchChatHeaderState createState() => SearchChatHeaderState();
}

class SearchChatHeaderState extends State<SearchChatHeader> {
  TextEditingController searchController = TextEditingController();
  late ChartController chartController = Get.find<ChartController>();
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
          ),
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size50,
            margin: EdgeInsets.all(AppDimention.size10),
            padding: EdgeInsets.only(
                left: AppDimention.size20, right: AppDimention.size10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimention.size10)),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Tìm kiếm ...",
                hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
                prefixIcon: GestureDetector(
                  onTap: () {
                    chartController.searchUser(searchController.text);
                  },
                  child: const Icon(Icons.search),
                ),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: AppDimention.size15),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimention.size30),
                    borderSide: const BorderSide(width: 1.0, color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimention.size30),
                    borderSide: const BorderSide(width: 1.0, color: Colors.white)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
