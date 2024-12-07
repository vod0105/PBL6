import 'package:android_project/data/repository/User_repo.dart';
import 'package:android_project/models/Dto/AnnoUceDto.dart';
import 'package:android_project/models/Dto/RegisterShipperDto.dart';
import 'package:android_project/models/Dto/UserUpdateDto.dart';
import 'package:android_project/models/Model/AnnounceModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });
  bool isLoading = false;

  User? userProfile;

  Future<void> getUserProfile() async {
    isLoading = true;
    update();
    Response response = await userRepo.getUserProfile();
    if (response.statusCode == 200) {
      var data = response.body;
      userProfile = UserModel.fromJson(data).user;
    } else {}
    isLoading = false;
    update();
  }
  bool? loadReceiver ;
  Future<User?> getById(int id)async{
    loadReceiver = true;
    Response response = await userRepo.getById(id);
    if (response.statusCode == 200) {
      var data = response.body;
      loadReceiver = false;
      update();
      return UserModel.fromJson(data).user!;
    }
    else{
    }
    loadReceiver = false;
    update();
    return null;
  }
  
  String? base64Image;
  void updateAvatar(String newImage) {
  base64Image = newImage;
  update();
}


  Future<void> updateProfile(UserUpdateDto updateDto) async {
    isLoading = true;
    update();

    Response response = await userRepo.updateProfile(updateDto);
    if (response.statusCode == 200) {
      Get.snackbar(
            "Thông báo",
            "Cập nhật thành công",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black,
            icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            isDismissible: true,
            
          );
      getUserProfile();
    } else {
      Get.snackbar(
            "Thông báo",
            "Lỗi đã xảy ra . Vui lòng thử lại sau",
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
    isLoading = false;
    update();
  }

   Future<bool> registerShipper(RegisterShipperDto dto) async {
    update();

    Response response = await userRepo.registerShipper(dto);
    if (response.statusCode == 200) {
        return true;
    } else {
      return false;
    }
    
  }
  List<AnnounceData> listAnnoUce = [];
  bool loadingAnnoUce = false;
  Future<void> getAnnounce()async{
      loadingAnnoUce = true;
      Response response = await userRepo.getAnnounce();
      if(response.statusCode == 200){
        var data = response.body;
        
        listAnnoUce = [];
        listAnnoUce.addAll(AnnounceModel.fromJson(data).announce ?? []);
       
      }
      else{
        listAnnoUce = [];
      }
      loadingAnnoUce = false;
      update();
  }
  Future<void> addAnnoUce(String title,String content) async{
    int userid = userProfile!.id!;
    AnnoUceDto annoUceDto = AnnoUceDto(userid: userid, title: title, content: content);
    Response response = await userRepo.addAnnoUce(annoUceDto);
    if(response.statusCode !=200){
    }
  }
  Future<void> addAnnoUceV2( int userid,String title,String content) async{
    AnnoUceDto annoUceDto = AnnoUceDto(userid: userid, title: title, content: content);
    Response response = await userRepo.addAnnoUce(annoUceDto);
    if(response.statusCode !=200){
    }
  }
}
