import 'package:android_project/data/controller/Promotion_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PromotionBody extends StatefulWidget {
  const PromotionBody({
    super.key,
  });
  @override
  PromotionBodyState createState() => PromotionBodyState();
}

class PromotionBodyState extends State<PromotionBody> {
  PromotionController promotionController = Get.find<PromotionController>();
  Storecontroller storecontroller = Get.find();
  @override
  void initState() {
    super.initState();
    promotionController.getAll();
    promotionController.getByUser();
  }

   String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromotionController>(builder: (controller) {
      return controller.loaDing!
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
              children:  controller.listPromotion.map((item) {
                return Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  margin: EdgeInsets.all(AppDimention.size10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimention.size10),
                      image: DecorationImage(
                          image: promotionController.checkVoucher(item.code!) ? const AssetImage("assets/image/Voucher0.png") : const AssetImage("assets/image/Voucher2.png"),fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mã code : ${item.code}",
                        style: TextStyle(color:promotionController.checkVoucher(item.code!) ? Colors.white : Colors.black),
                      ),
                      Text(
                        "Giá trị : ${item.discountPercent!.toInt()} %",
                        style: TextStyle(color:promotionController.checkVoucher(item.code!) ? Colors.white : Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(item.startDate!),
                            style: TextStyle(color:promotionController.checkVoucher(item.code!) ? Colors.white : Colors.black),
                          ),
                          Text(
                            formatTime(item.endDate!),
                            style: TextStyle(color:promotionController.checkVoucher(item.code!) ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        width: AppDimention.screenWidth,
                        margin: EdgeInsets.only(top: AppDimention.size10),
                        
                        child: Column(
                          children: item.storeId!.map((item) {
                            StoresItem? storeItem =
                                storecontroller.getStoreById(item);
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.get_store_detail(
                                    storeItem.storeId!));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size5)),
                                width: AppDimention.screenWidth,
                                padding: EdgeInsets.all(AppDimention.size10),
                                margin: EdgeInsets.only(
                                    bottom: AppDimention.size10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${storeItem!.storeName}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text("${storeItem.location}"),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      if(promotionController.checkVoucher(item.code!))
                        GestureDetector(
                          onTap: (){
                              promotionController.savePromotion(item.voucherId!);
                          },
                          child: Container(
                          width: AppDimention.size100,
                          height: AppDimention.size40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppDimention.size5),
                          ),
                          child: const Center(
                            child: Text("Lưu"),
                          ),
                        ),
                        )
                    ],
                  ),
                );
              }).toList(),
            );
    });
  }
}
