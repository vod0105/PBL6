import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/data/repository/Combo_repo.dart';
import 'package:android_project/models/Dto/AddComboToCartDto.dart';
import 'package:android_project/models/Dto/OrderComboDto.dart';
import 'package:android_project/models/Model/ComboModel.dart';
import 'package:android_project/models/Model/Item/ComboItem.dart';
import 'package:android_project/models/Model/MomoModel.dart';
import 'package:android_project/models/Model/ZaloModels.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComboController extends GetxController {
  final ComboRepo comboRepo;
  ComboController({
    required this.comboRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ComboItem> _comboList = [];
  List<ComboItem> get comboList => _comboList;



  Future<void> getAll() async {
    _isLoading = true;
    Response response = await comboRepo.getAll();

    if (response.statusCode == 200) {
      var data = response.body;
      _comboList = [];
      _comboList.addAll(ComboModel.fromJson(data).listCombo ?? []);
    } else {
      _comboList = [];
    }
    _isLoading = false;
    update();
  }
  MoMoModels _qrcode = MoMoModels();
  MoMoModels get qrcode => _qrcode;
   ZaloData _qrcodeZalo = ZaloData();
  ZaloData get qrcodeZalo => _qrcodeZalo;

  bool ordering  = false;
  Future<void> order(OrderComboDto dto) async{
    ordering = true;
    Response response = await comboRepo.order(dto);
    if(response.statusCode == 200){
      var data = response.body;
      if (dto.paymentMethod == "CASH") {
        
           Get.snackbar(
            "Thông báo",
            "Đặt đơn hàng thành công",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black,
            icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            isDismissible: true,
            
          );
          Get.find<UserController>().addAnnoUce("Thông báo đơn hàng", "Bạn vừa đặt thành công một đơn hàng !"); 
        } else if (dto.paymentMethod  == "MOMO") {
          
          _qrcode = (MoMoModels.fromJson(data).moMo);
        }
        else{
        _qrcodeZalo = ZaloModels.fromJson(data).zaloData!;
        }
    }
    else{
      var data = response.body;
       Get.snackbar(
            "Thông báo",
            data["message"],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black,
            icon: const Icon(Icons.card_giftcard_sharp, color: Colors.red),
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            isDismissible: true,
            
          );
    }
    ordering = false;
    update();
  }

  ComboItem? getComboById(int id){
    for(ComboItem item in _comboList){
      if(item.comboId == id) {
        return item;
      }
    }
    return null;
  }
  Future<List<ComboItem>> getComboByStoreId(int storeId) async{
    List<ComboItem> list = [];
      Response response = await comboRepo.getByStoreId(storeId);
      if(response.statusCode == 200){
        var data = response.body;
        list.addAll(ComboModel.fromJson(data).listCombo ?? []);
        
      }
      else{
      }
      return list;
  }
  Future<void> addComboToCart(ComboToCartDto dto) async{
    Response response = await comboRepo.addToCart(dto);
    if(response.statusCode == 200){
        Get.snackbar(
            "Thông báo",
            "Thêm vào giỏ hàng thành công",
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
    else{
    }
  }
}
