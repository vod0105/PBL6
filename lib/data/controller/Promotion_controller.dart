import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/repository/Promotion_repo.dart';
import 'package:android_project/models/Model/PromotionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PromotionController extends GetxController {
  final PromotionRepo promotionRepo;
  PromotionController({
    required this.promotionRepo,
  });
  bool isDateBeforeToday(String inputDate) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime date = dateFormat.parse(inputDate);
    DateTime today = DateTime.now();
    DateTime todayOnlyDate = DateTime(today.year, today.month, today.day);
    return date.isBefore(todayOnlyDate);
  }

  Storecontroller storecontroller = Get.find<Storecontroller>();
  bool? loaDing;
  List<PromotionData> listPromotion = [];

  Future<void> getAll() async {
    loaDing = true;
    Response response = await promotionRepo.getAll();
    if (response.statusCode == 200) {
      var data = response.body;
      listPromotion = [];
      List<PromotionData> listVoucher = [];
      listVoucher.addAll(PromotionModel.fromJson(data).listPromotion ?? []);
      for (PromotionData item in listVoucher) {
        if (!isDateBeforeToday(item.endDate!)) {
          listPromotion.add(item);
        }
      }
    } else {}
    loaDing = false;
    update();
  }

  List<PromotionData> listPromotionByStoreId = [];
  bool? loadingByStoreId = false;
  Future<void> getByStoreId(int storeId) async {
    listPromotionByStoreId = [];
    loadingByStoreId = true;
    Response response = await promotionRepo.getByStoreId(storeId);
    if (response.statusCode == 200) {
      var data = response.body;
      List<PromotionData> listVoucher = [];
      listVoucher.addAll(PromotionModel.fromJson(data).listPromotion ?? []);
      for (PromotionData item in listVoucher) {
        if (!isDateBeforeToday(item.endDate!)) {
          listPromotionByStoreId.add(item);
        }
      }
    } else {}
    loadingByStoreId = false;
    update();
  }

  List<PromotionData> listPromotionByUser = [];
  bool? loadingByUser = false;
  Future<void> getByUser() async {
    listPromotionByUser = [];
    loadingByUser = true;
    Response response = await promotionRepo.getByUser();
    if (response.statusCode == 200) {
      var data = response.body;
      List<PromotionData> listVoucher = [];
      listVoucher.addAll(PromotionModel.fromJson(data).listPromotion ?? []);
      for (PromotionData item in listVoucher) {
        if (!isDateBeforeToday(item.endDate!)) {
          listPromotionByUser.add(item);
        }
      }
    } else {}
    loadingByUser = false;
    update();
  }

  List<PromotionData> getVoucherByUser() {
    List<PromotionData> result = [];
    for (PromotionData item in listPromotionByUser) {
      if (!isDateBeforeToday(item.endDate!) &&
          isDateBeforeToday(item.startDate!) &&
          item.used! == false) {
        result.add(item);
      }
    }
    return result;
  }

  List<PromotionData> getByStoreIdAndUser(int storeId) {
    List<PromotionData> result = [];
    for (PromotionData item in listPromotionByUser) {
      if (item.storeId!.contains(storeId) &&
          !isDateBeforeToday(item.endDate!) &&
          isDateBeforeToday(item.startDate!) &&
          item.used! == false) {
        result.add(item);
      }
    }
    return result;
  }

  bool checkVoucher(String code) {
    for (PromotionData item in listPromotionByUser) {
      if (item.code == code) {
        return false;
      }
    }
    return true;
  }

  void savePromotion(int voucherId) async {
    Response response = await promotionRepo.savePromotion(voucherId);
    if (response.statusCode == 200) {
      Get.snackbar(
        "Thông báo",
        "Lưu mã giảm giá thành công",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
      getAll();
      getByUser();
    } else {
      Get.snackbar(
        "Thông báo",
        "Lưu mã giảm giá thất bại",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    }
  }
}
