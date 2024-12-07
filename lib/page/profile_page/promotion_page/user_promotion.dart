import 'package:android_project/data/controller/Promotion_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/page/profile_page/promotion_page/promotion_header.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserPromotion extends StatefulWidget {
  const UserPromotion({
    super.key,
  });
  @override
  UserPromotionState createState() => UserPromotionState();
}

class UserPromotionState extends State<UserPromotion> {
  PromotionController promotionController = Get.find();
  Storecontroller storecontroller = Get.find();
  @override
  void initState() {
    super.initState();
    promotionController.getByUser();
  }

  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const PromotionHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  child: const Text("Dành cho bạn"),
                ),
                GetBuilder<PromotionController>(builder: (controller) {
                  return controller.loadingByUser!
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      :controller.listPromotion.isEmpty ? SizedBox(
            width: Get.width,
            height: 100,
            child: const Center(
              child: Text("Hiện không có mã giảm giá"),
            ),
          ) : Column(
                          children: controller.listPromotionByUser.map((item) {
                            return Container(
                              width: AppDimention.screenWidth,
                              padding: EdgeInsets.all(AppDimention.size10),
                              margin: EdgeInsets.all(AppDimention.size10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10),
                                  color: item.used!
                                      ? Colors.grey[200]
                                      : Colors.green),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mã code : ${item.code}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Giá trị : ${item.discountPercent!.toInt()} %",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatTime(item.startDate!),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        formatTime(item.endDate!),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: AppDimention.screenWidth,
                                    margin: EdgeInsets.only(
                                        top: AppDimention.size10),
                                    padding:
                                        EdgeInsets.all(AppDimention.size10),
                                    child: Column(
                                      children: item.storeId!.map((item) {
                                        StoresItem? storeItem =
                                            storecontroller.getStoreById(item);
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoute.get_store_detail(storeItem.storeId!));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size5)),
                                            width: AppDimention.screenWidth,
                                            padding: EdgeInsets.all(
                                                AppDimention.size10),
                                            margin: EdgeInsets.only(
                                                bottom: AppDimention.size10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("${storeItem!.storeName}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                                Text("${storeItem.location}"),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        );
                })
              ],
            ),
          )),
        ],
      ),
    );
  }
}
