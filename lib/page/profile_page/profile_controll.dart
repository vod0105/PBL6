import 'package:android_project/page/chat_page/home_chart/home_chat.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileControll extends StatefulWidget {
  const ProfileControll({
    super.key,
  });

  @override
  ProfileControllState createState() => ProfileControllState();
}

class ProfileControllState extends State<ProfileControll> {
  PageController pageController = PageController(viewportFraction: 0.96);
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        if (pageController.page != null) {
          currentPageValue = pageController.page!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppDimention.screenWidth,
        height: AppDimention.size100,
        padding: EdgeInsets.all(AppDimention.size10),
        margin: EdgeInsets.all(AppDimention.size10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(AppDimention.size10),
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.ORDER_PAGE);
              },
              child: Container(
                width: AppDimention.size80,
                height: AppDimention.size80,
                padding: EdgeInsets.all(AppDimention.size5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimention.size10),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.food_bank_outlined,
                      size: 27,
                      color: Colors.black54,
                    ),
                    Text(
                      "Đơn hàng",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(AppRoute.PROMOTION_PAGE);
              },
              child: Container(
              width: AppDimention.size80,
              height: AppDimention.size80,
              padding: EdgeInsets.all(AppDimention.size5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.airplane_ticket,
                    size: 27,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: AppDimention.size5,
                  ),
                  const Text(
                    "Giảm giá",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            ),
            GestureDetector(
              onTap: () {
                // Get.toNamed(AppRoute.CHART_PAGE);
                Get.to(const HomeChat());
              },
              child: Container(
                width: AppDimention.size80,
                height: AppDimention.size80,
                padding: EdgeInsets.all(AppDimention.size5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimention.size10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline_outlined,
                      size: 27,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      height: AppDimention.size5,
                    ),
                    const Text(
                      "Tin nhắn",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
