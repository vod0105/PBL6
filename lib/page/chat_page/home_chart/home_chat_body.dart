import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeChatBody extends StatefulWidget {
  const HomeChatBody({
    super.key,
  });
  @override
  HomeChatBodyState createState() => HomeChatBodyState();
}

class HomeChatBodyState extends State<HomeChatBody> {
  ChartController chartController = Get.find<ChartController>();
  @override
  void initState() {
    super.initState();
    chartController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (listUserController) {
        return listUserController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: listUserController.listUser.map((item) {
                  return GestureDetector(
                    onTap: ()  {
                      Get.toNamed(AppRoute.user_chat_detail(item.id!));
                    },
                    child: Container(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size80,
                      padding: EdgeInsets.only(left: AppDimention.size10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: AppDimention.size60,
                            height: AppDimention.size60,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size100),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:  AssetImage(
                                        "assets/image/LoadingBg.png"))),
                          ),
                          SizedBox(width: AppDimention.size10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.circle,color: Colors.green,size: 18,),
                                  SizedBox(width: AppDimention.size5,),
                                  Text(
                                    item.fullName.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
      },
    );
  }
}
